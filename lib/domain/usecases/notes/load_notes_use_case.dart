import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/data/mapper/notes_mapper.dart';
import 'package:encrypted_notes/data/remote/models/delete_notes/delete_notes.dart';
import 'package:encrypted_notes/domain/failures/failures.dart';
import 'package:encrypted_notes/domain/models/failedDeletedNotes/failedDeletedNotes.dart';
import 'package:encrypted_notes/domain/models/notes/notes.dart';
import 'package:encrypted_notes/domain/models/request_status.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_local_repository.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_remote_repository.dart';
import 'package:encrypted_notes/domain/repositories/secret_shared_preferences_repository.dart';
import 'package:encrypted_notes/domain/repositories/synced_client_repository_local.dart';
import 'package:encrypted_notes/domain/usecases/encryption/message_encryption_use_case.dart';

class GetNotesResponse {
  final Stream<List<EncryptedNote>> notesStream;
  final Stream<RequestStatus> loadingNotesFromServerStatus;

  GetNotesResponse({
    required this.loadingNotesFromServerStatus,
    required this.notesStream,
  });
}

class LoadNoteUseCase {
  LoadNoteUseCase({
    required ModifyNoteLocalRepository modifyNoteRepository,
    required ModifyNoteRemoteRepository modifyNoteRemoteRepository,
    required NotesMapper notesMapper,
    required SecretSharedPreferencesRepository
        secretSharedPreferencesRepository,
    required MessageEncryptionUseCase messageEncryptionUseCase,
    required RemoteDeviceRepositoryLocal remoteDeviceRepositoryLocal,
  })  : _modifyNoteLocalRepository = modifyNoteRepository,
        _modifyNoteRemoteRepository = modifyNoteRemoteRepository,
        _notesMapper = notesMapper,
        _secretSharedPreferencesRepository = secretSharedPreferencesRepository,
        _messageEncryptionUseCase = messageEncryptionUseCase,
        _remoteDeviceRepositoryLocal = remoteDeviceRepositoryLocal;

  final ModifyNoteLocalRepository _modifyNoteLocalRepository;
  final ModifyNoteRemoteRepository _modifyNoteRemoteRepository;
  final NotesMapper _notesMapper;
  final SecretSharedPreferencesRepository _secretSharedPreferencesRepository;
  final MessageEncryptionUseCase _messageEncryptionUseCase;
  final RemoteDeviceRepositoryLocal _remoteDeviceRepositoryLocal;

  GetNotesResponse getNotes() {
    return GetNotesResponse(
      notesStream: _modifyNoteLocalRepository.getNotes(),
      loadingNotesFromServerStatus: _getLoadingNotesFromServer(),
    );
  }

  Stream<RequestStatus> _getLoadingNotesFromServer() async* {
    yield RequestStatus.loading;
    try {
      late List<GetAllNotesResponse> notesFromServer;
      late List<EncryptedNote> notesWhichHasUnSyncedDevice;
      late List<FailedDeletedNote> failedDeletedNote;
      late List<GetRemovingNotesResponse> deletedNotesForLocalSync;

      await Future.wait([
        _modifyNoteRemoteRepository
            .getNotes()
            .then((value) => notesFromServer = value),
        _modifyNoteLocalRepository
            .getNotesWhichHasUnSyncedDevice()
            .then((value) => notesWhichHasUnSyncedDevice = value),
        _modifyNoteLocalRepository
            .getAllFailedDeletedNote()
            .then((value) => failedDeletedNote = value),
        _modifyNoteRemoteRepository
            .getRemovingNotes()
            .then((value) => deletedNotesForLocalSync = value),
      ]);

      final List<String> deletedNoteSync = [];
      for (var deletedNote in deletedNotesForLocalSync) {
        final isSuccess = await _modifyNoteLocalRepository
            .deleteNoteByGlobalId(deletedNote.noteGlobalId);

        if (isSuccess == true) {
          deletedNoteSync.add(deletedNote.noteGlobalId);
        }
      }

      if (deletedNoteSync.isNotEmpty) {
        _modifyNoteRemoteRepository
            .confirmRemovingNoteFromDevice(deletedNoteSync);
      }

      final _notes = await Future.wait(
        notesFromServer.map((data) async {
          final device = await _remoteDeviceRepositoryLocal
              .getRemoteDeviceById(data.sendFromDeviceId);

          if (device == null) {
            // TODO можливо спробувати запитати в сервера remoteDevice
            return null;
          }

          final decryptedTitle =
              await _messageEncryptionUseCase.decryptMessageE2E(
            data.title,
            device.devicePublicKey,
          );

          final decryptedMessage =
              await _messageEncryptionUseCase.decryptMessageE2E(
            data.message,
            device.devicePublicKey,
          );

          print("decryptedMessage: ${decryptedMessage}");

          final localSecretKey =
              await _secretSharedPreferencesRepository.getLocalSymmetricKey();

          final encryptedMessageLocal =
              await _messageEncryptionUseCase.encryptMessageForLocal(
            decryptedMessage,
            localSecretKey,
          );

          final indexMatched = notesWhichHasUnSyncedDevice.indexWhere(
              (element) => element.noteGlobalId == data.noteGlobalId);
          final localNoteUnSyncedDevicesId = indexMatched == -1
              ? List.empty()
              : notesWhichHasUnSyncedDevice[indexMatched]
                  .syncedDevices
                  .where((element) => element.isSynced == false)
                  .toList();

          print("localNoteUnSyncedDevicesId: ${localNoteUnSyncedDevicesId}");

          final isUnSynced = localNoteUnSyncedDevicesId.any((element) {
            return data.syncedWithDevicesId.contains(element.deviceId) == true;
          });
          print("isUnSynced: ${isUnSynced}");
          final isFailedDeleted = failedDeletedNote
              .any((element) => element.noteGlobalId == data.noteGlobalId);
          print("isFailedDeleted: ${isFailedDeleted}");

          // ** If we have conflict between local and remote don't override local data
          if (isUnSynced || isFailedDeleted) {
            return null;
          }

          return NotesCompanion(
            noteGlobalId: Value(data.noteGlobalId),
            message: Value(jsonEncode(encryptedMessageLocal.toJson())),
            title: Value(decryptedTitle),
            createdAt: Value(data.createdAt),
            updatedAt: Value(data.updatedAt),
            syncedDevicesJson: Value(
              jsonEncode(
                data.syncedWithDevicesId.map((syncedDeviceId) {
                  return SyncedDevice(
                    deviceId: syncedDeviceId,
                    isSynced: true,
                    // todo add wasDeleted
                  );
                }).toList(),
              ),
            ),
          );
        }).toList(),
      );

      List<NotesCompanion> notes = _notes
          .where((element) => element != null)
          .toList()
          .cast<NotesCompanion>();
// Зараз оверрайдтиь , але може бути так що локально все ок, а на сервер не відправилось в такому випадку сервер знищить локальні дані (треба дивитися чи isSinced: tue)
      _modifyNoteLocalRepository.replaceLocalNotesWithRemote(notes);

      yield RequestStatus.success;
    } catch (e) {
      print("_getLoadingNotesFromServer error: ${e}");
      yield RequestStatus.failed;
    }
  }

  Future<Either<Failure, Note>> loadNoteById(int noteId) async {
    try {
      final loadedNote = await _modifyNoteLocalRepository.getNoteById(noteId);
      if (loadedNote == null) {
        return left(GeneralFailure(message: "can't find note"));
      }

      final localSecretKey =
          await _secretSharedPreferencesRepository.getLocalSymmetricKey();
      final String decryptedMessage =
          await _messageEncryptionUseCase.decryptMessageForLocal(
        loadedNote.message,
        localSecretKey,
      );

      return right(
          _notesMapper.encryptedNoteToNote(loadedNote, decryptedMessage));
    } catch (e) {
      return left(GeneralFailure(message: "error"));
    }
  }
}
