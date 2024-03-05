import 'dart:async';
import 'dart:convert';
import 'package:encrypted_notes/data/mapper/notes_mapper.dart';

import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/domain/failures/failures.dart';
import 'package:encrypted_notes/domain/models/combined_local_remote_response/combined_local_remote_response.dart';
import 'package:encrypted_notes/domain/models/notes/notes.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_local_repository.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_remote_repository.dart';
import 'package:encrypted_notes/domain/repositories/secret_shared_preferences_repository.dart';
import 'package:encrypted_notes/domain/repositories/synced_client_repository_local.dart';
import 'package:encrypted_notes/domain/usecases/encryption/message_encryption_use_case.dart';

typedef LocalAddResponse = Future<Either<Failure, int>>;
typedef RemoteAddResponse = Future<Either<Failure, bool>>;
typedef AddNoteResponse
    = Future<CombinedLocalRemoteResponse<LocalAddResponse, RemoteAddResponse>>;

class AddNoteUseCase {
  AddNoteUseCase(
      {required ModifyNoteLocalRepository modifyNoteLocalRepository,
      required ModifyNoteRemoteRepository modifyNoteRemoteRepository,
      required MessageEncryptionUseCase messageEncryptionUseCase,
      required SecretSharedPreferencesRepository
          secretSharedPreferencesRepository,
      required NotesMapper notesMapper,
      required RemoteDeviceRepositoryLocal remoteDeviceRepositoryLocal})
      : _modifyNoteLocalRepository = modifyNoteLocalRepository,
        _modifyNoteRemoteRepository = modifyNoteRemoteRepository,
        _messageEncryptionUseCase = messageEncryptionUseCase,
        _secretSharedPreferencesRepository = secretSharedPreferencesRepository,
        _notesMapper = notesMapper,
        _remoteDeviceRepositoryLocal = remoteDeviceRepositoryLocal;

  final ModifyNoteLocalRepository _modifyNoteLocalRepository;
  final ModifyNoteRemoteRepository _modifyNoteRemoteRepository;
  final NotesMapper _notesMapper;
  final MessageEncryptionUseCase _messageEncryptionUseCase;
  final SecretSharedPreferencesRepository _secretSharedPreferencesRepository;
  final RemoteDeviceRepositoryLocal _remoteDeviceRepositoryLocal;

  final List<SyncedDevice> syncedDeviceList = [];

  AddNoteResponse addNote({
    required String message,
    required String title,
    required List<SyncedDevice> syncedDevices,
  }) async {
    syncedDeviceList.addAll(syncedDevices);
    final local = _addNoteLocally(
      message: message,
      title: title,
    );
    return CombinedLocalRemoteResponse(
      local: local,
      remote: local.then((value) => _prepareAndAddNoteRemote(value)),
    );
  }

  LocalAddResponse _addNoteLocally({
    required String message,
    required String title,
  }) async {
    try {
      final newSyncedDevices = syncedDeviceList
          .map(
              (syncedDevice) => syncedDevice.copyWith(isSynced: false).toJson())
          .toList();

      final localSecretKey =
          await _secretSharedPreferencesRepository.getLocalSymmetricKey();

      final encryptedMessage =
          await _messageEncryptionUseCase.encryptMessageForLocal(
        message,
        localSecretKey,
      );

      final gson = encryptedMessage.toJson();
      final jsonString = jsonEncode(gson);
      final jsonSyncedDevices = jsonEncode(newSyncedDevices);
      final result = await _modifyNoteLocalRepository.addNote(
        NotesCompanion(
          message: Value(jsonString),
          title: Value(title),
          syncedDevicesJson: Value(jsonSyncedDevices),
        ),
      );

      return right(result);
    } catch (e) {
      return left(GeneralFailure(message: "local error"));
    }
  }

  RemoteAddResponse _prepareAndAddNoteRemote(Either<Failure, int> value) async {
    return value.fold(
      (l) {
        return left(GeneralFailure(message: "no local message"));
      },
      (r) async {
        final note = await _modifyNoteLocalRepository.getNoteById(r);

        final isNoteExist = note != null;
        if (!isNoteExist) {
          return left(
              GeneralFailure(message: "can't load local message by id"));
        }

        final localSecretKey =
            await _secretSharedPreferencesRepository.getLocalSymmetricKey();

        final decryptedMessage =
            await _messageEncryptionUseCase.decryptMessageForLocal(
          note.message,
          localSecretKey,
        );

        return _addNoteRemote(
          note: _notesMapper.encryptedNoteToNote(note, decryptedMessage),
        );
      },
    );
  }

  RemoteAddResponse _addNoteRemote({required Note note}) async {
    try {
      final encryptedData = await _encryptNoteForEachRecipient(note: note);
      final result = await _modifyNoteRemoteRepository
          .addNotes([NoteForServer(data: encryptedData, noteGlobalId: null)]);

      for (var responseNote in result) {
        await _synchronizeRemoteResponse(
          responseNote.addNotesDeviceInfoResponse,
          note.id,
          responseNote.noteGlobalId,
        );
      }

      return right(true);
    } catch (e) {
      return left(GeneralFailure(message: "remote error"));
    }
  }

  Future<List<NoteDataForServer>> _encryptNoteForEachRecipient({
    required Note note,
  }) async {
    final remoteDevices =
        await _remoteDeviceRepositoryLocal.getListRemoteDeviceById(
            syncedDeviceList.map((e) => e.deviceId).toList());

    final futureEncryptedDeviceList = remoteDevices.map((remoteDevice) async {
      final titleCipher = await _messageEncryptionUseCase.encryptMessageE2E(
          note.title, remoteDevice.devicePublicKey);
      final messageCipher = await _messageEncryptionUseCase.encryptMessageE2E(
          note.message, remoteDevice.devicePublicKey);

      final encryptedData = NoteDataForServerEncryptedData(
        title: titleCipher,
        message: messageCipher,
      );

      return NoteDataForServer(
        metaData: NoteDataForServerMetaData(
          createdAt: note.createdAt,
          updatedAt: note.updatedAt,
          sendToDeviceId: remoteDevice.id,
          noteGlobalId: null,
        ),
        data:
            _notesMapper.noteDataForServerEncryptedDataToNoteDataForServerData(
                encryptedData),
      );
    }).toList();

    List<NoteDataForServer> resultFuture =
        await Future.wait(futureEncryptedDeviceList);
    return resultFuture;
  }

  Future _synchronizeRemoteResponse(
    List<NotesDeviceInfoResponse> response,
    int noteId,
    String noteGlobalId,
  ) async {
    final syncingDeviceStatusList = response
        .map((item) => SyncedDevice(
              deviceId: item.deviceId,
              isSynced: item.isSuccess,
            ))
        .toList();

    await AppDatabase.getInstance().transaction(() async {
      await _modifyNoteLocalRepository.updateSyncingDeviceForNote(
        jsonEncode(syncingDeviceStatusList),
        noteId,
      );

      await _modifyNoteLocalRepository.addGlobalIdToNote(noteGlobalId, noteId);
    });
  }
}
