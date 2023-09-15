import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/data/mapper/notes_mapper.dart';
import 'package:encrypted_notes/domain/models/notes/notes.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_local_repository.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_remote_repository.dart';
import 'package:encrypted_notes/domain/repositories/secret_shared_preferences_repository.dart';
import 'package:encrypted_notes/domain/usecases/encryption/message_encryption_use_case.dart';
import 'package:encrypted_notes/domain/usecases/notes/get_synced_device_list.dart';

import '../../failures/failures.dart';
import '../../models/combined_local_remote_response/combined_local_remote_response.dart';

typedef LocalEditResponse = Future<Either<Failure, bool>>;
typedef RemoteEditResponse = Future<Either<Failure, bool>>;
typedef EditNoteResponse = Future<
    CombinedLocalRemoteResponse<LocalEditResponse, RemoteEditResponse>>;

class EditNoteUseCase {
  EditNoteUseCase({
    required ModifyNoteLocalRepository modifyNoteLocalRepository,
    required ModifyNoteRemoteRepository modifyNoteRemoteRepository,
    required GetSyncedDeviceListUseCase getSyncedDeviceListUseCase,
    required SecretSharedPreferencesRepository
        secretSharedPreferencesRepository,
    required MessageEncryptionUseCase messageEncryptionUseCase,
    required NotesMapper notesMapper,
  })  : _modifyNoteLocalRepository = modifyNoteLocalRepository,
        _modifyNoteRemoteRepository = modifyNoteRemoteRepository,
        _getSyncedDeviceListUseCase = getSyncedDeviceListUseCase,
        _secretSharedPreferencesRepository = secretSharedPreferencesRepository,
        _messageEncryptionUseCase = messageEncryptionUseCase,
        _notesMapper = notesMapper;

  final ModifyNoteLocalRepository _modifyNoteLocalRepository;
  final ModifyNoteRemoteRepository _modifyNoteRemoteRepository;
  final GetSyncedDeviceListUseCase _getSyncedDeviceListUseCase;
  final NotesMapper _notesMapper;
  final SecretSharedPreferencesRepository _secretSharedPreferencesRepository;
  final MessageEncryptionUseCase _messageEncryptionUseCase;

  final List<SyncedDevice> syncedDeviceList = [];

  _getSyncedDeviceList() async {
    final result = await _getSyncedDeviceListUseCase.getSyncedDeviceList();
    syncedDeviceList.addAll(result);
  }

  EditNoteResponse editNote({required Note note}) async {
    // I use syncedDeviceList because event syncedDeviceList exist in note it may ve outdated. I should always use the latest data
    await _getSyncedDeviceList();

    return CombinedLocalRemoteResponse(
      local: _editNoteLocally(note: note),
      remote: _editNoteRemote(note: note),
    );
  }

  LocalEditResponse _editNoteLocally({required Note note}) async {
    try {
      final syncedDevices = syncedDeviceList
          .map((syncedDevice) => syncedDevice.copyWith(isSynced: false))
          .toList();

      final localSecretKey =
          await _secretSharedPreferencesRepository.getLocalSymmetricKey();

      final encryptedMessage = await _messageEncryptionUseCase.encryptMessageForLocal(
        note.message,
        localSecretKey,
      );

      final result = await _modifyNoteLocalRepository.editNote(
        NotesCompanion(
          id: Value(note.id),
          message: Value(jsonEncode(encryptedMessage.toJson())),
          title: Value(note.title),
          syncedDevicesJson: Value(jsonEncode(syncedDevices)),
        ),
      );

      return right(result);
    } catch (e) {
      return left(GeneralFailure(message: "local error: ${e}"));
    }
  }

  RemoteEditResponse _editNoteRemote({required Note note}) async {
    try {
      if (note.globalId == null) {
        return left(GeneralFailure(message: "no global id"));
      }
      final encryptedNoteList = await _encryptNoteForEachRecipient(note: note);

      final result = await _modifyNoteRemoteRepository.editNotes([
        NoteForServer(globalId: note.globalId, data: encryptedNoteList),
      ]);

      for (var responseNote in result) {
        await _synchronizeRemoteResponse(
          responseNote.addNotesDeviceInfoResponse,
          note.id,
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
    final futureEncryptedDeviceList =
        syncedDeviceList.map((_syncedDevice) async {
      final titleCipher = await _messageEncryptionUseCase.encryptMessageE2E(
        note.title,
        _syncedDevice.devicePublicKey,
      );
      final messageCipher = await _messageEncryptionUseCase.encryptMessageE2E(
        note.message,
        _syncedDevice.devicePublicKey,
      );

      final encryptedData = NoteDataForServerEncryptedData(
        title: titleCipher,
        message: messageCipher,
      );

      return NoteDataForServer(
        metaData: NoteDataForServerMetaData(
          createdAt: note.createdAt,
          updatedAt: note.updatedAt,
          sendToDeviceId: _syncedDevice.deviceId,
          globalId: note.globalId,
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
  ) async {
    final syncingDeviceStatusList = response
        .map((item) => SyncedDevice(
              deviceId: item.deviceId,
              isSynced: item.isSuccess,
              devicePublicKey: item.devicePublicKey,
            ))
        .toList();

    await AppDatabase.getInstance().transaction(() async {
      await _modifyNoteLocalRepository.updateSyncingDeviceForNote(
        jsonEncode(syncingDeviceStatusList),
        noteId,
      );
    });
  }
}
