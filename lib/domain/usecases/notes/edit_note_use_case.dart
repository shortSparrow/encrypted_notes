import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/data/mapper/notes_mapper.dart';
import 'package:encrypted_notes/domain/models/notes/modify_notes.dart';
import 'package:encrypted_notes/domain/models/notes/notes.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_local_repository.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_remote_repository.dart';
import 'package:encrypted_notes/domain/repositories/secret_shared_preferences_repository.dart';
import 'package:encrypted_notes/domain/repositories/synced_client_repository_local.dart';
import 'package:encrypted_notes/domain/usecases/encryption/message_encryption_use_case.dart';

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
    required SecretSharedPreferencesRepository
        secretSharedPreferencesRepository,
    required MessageEncryptionUseCase messageEncryptionUseCase,
    required NotesMapper notesMapper,
    required RemoteDeviceRepositoryLocal remoteDeviceRepositoryLocal,
  })  : _modifyNoteLocalRepository = modifyNoteLocalRepository,
        _modifyNoteRemoteRepository = modifyNoteRemoteRepository,
        _secretSharedPreferencesRepository = secretSharedPreferencesRepository,
        _messageEncryptionUseCase = messageEncryptionUseCase,
        _notesMapper = notesMapper,
        _remoteDeviceRepositoryLocal = remoteDeviceRepositoryLocal;

  final ModifyNoteLocalRepository _modifyNoteLocalRepository;
  final ModifyNoteRemoteRepository _modifyNoteRemoteRepository;
  final NotesMapper _notesMapper;
  final SecretSharedPreferencesRepository _secretSharedPreferencesRepository;
  final MessageEncryptionUseCase _messageEncryptionUseCase;
  final RemoteDeviceRepositoryLocal _remoteDeviceRepositoryLocal;

  EditNoteResponse editNote({required Note note}) async {
    return CombinedLocalRemoteResponse(
      local: _editNoteLocally(note: note),
      remote: _editNoteRemote(note: note),
    );
  }

  LocalEditResponse _editNoteLocally({required Note note}) async {
    try {
      final syncedDevices = note.syncedDevices
          .map((syncedDevice) => syncedDevice.copyWith(isSynced: false))
          .toList();

      final localSecretKey =
          await _secretSharedPreferencesRepository.getLocalSymmetricKey();

      final encryptedMessage =
          await _messageEncryptionUseCase.encryptMessageForLocal(
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
      if (note.syncedDevices.isEmpty) {
        return left(GeneralFailure(message: "syncedDevices is empty"));
      }

      final encryptedNoteList = await _encryptNoteForEachRecipient(note: note);
      if (note.noteGlobalId != null) {
        final result =
            await _modifyNoteRemoteRepository.editNote(encryptedNoteList);

        await _synchronizeRemoteResponse(
          result,
          note.id,
        );
      } else {
        // for cases when user create locally and can't send to server (internet trouble), this means note has not noteGlobalId,and this not exist on server
        // So we should add this note to server as addNote() not updateNote()
        final result =
            await _modifyNoteRemoteRepository.addNote(encryptedNoteList);

        await _modifyNoteLocalRepository.addGlobalIdToNote(
          result.noteGlobalId,
          note.id,
        );

        await _synchronizeRemoteResponse(
          EditNotesResponse(
            notes: result.notes,
            noteGlobalId: result.noteGlobalId,
          ),
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
    final remoteDevices =
        await _remoteDeviceRepositoryLocal.getListRemoteDeviceById(
            note.syncedDevices.map((e) => e.deviceId).toList());

    final futureEncryptedDeviceList = remoteDevices.map((remoteDevice) async {
      final titleCipher = await _messageEncryptionUseCase.encryptMessageE2E(
        note.title,
        remoteDevice.devicePublicKey,
      );
      final messageCipher = await _messageEncryptionUseCase.encryptMessageE2E(
        note.message,
        remoteDevice.devicePublicKey,
      );

      final encryptedData = NoteDataForServerEncryptedData(
        title: titleCipher,
        message: messageCipher,
      );

      return NoteDataForServer(
        metaData: NoteDataForServerMetaData(
          createdAt: note.createdAt,
          updatedAt: note.updatedAt,
          sendToDeviceId: remoteDevice.id,
          noteGlobalId: note.noteGlobalId,
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
    EditNotesResponse response,
    int noteId,
  ) async {
    final syncingDeviceStatusList = response.notes
        .map((item) => SyncedDevice(
              deviceId: item.deviceId,
              isSynced: item.isSuccess,
            ))
        .toList();

    final note = await _modifyNoteLocalRepository.getNoteById(noteId);
    final newSyncedDevices = note?.syncedDevices ?? List.empty();

    final updated = newSyncedDevices.map((_device) {
      final indexExistingDevice = syncingDeviceStatusList
          .indexWhere((element) => element.deviceId == _device.deviceId);

      if (indexExistingDevice != -1) {
        final updatedDevice =
            syncingDeviceStatusList.removeAt(indexExistingDevice);
        return updatedDevice;
      } else {
        return _device;
      }
    }).toList();

    updated.addAll(syncingDeviceStatusList);
    print("updated AFTER: ${updated}");

    await AppDatabase.getInstance().transaction(() async {
      await _modifyNoteLocalRepository.updateSyncingDeviceForNote(
        jsonEncode(updated),
        noteId,
      );
    });
  }
}
