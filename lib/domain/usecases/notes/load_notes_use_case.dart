import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/data/mapper/notes_mapper.dart';
import 'package:encrypted_notes/domain/failures/failures.dart';
import 'package:encrypted_notes/domain/failures/remote_repository_failures.dart';
import 'package:encrypted_notes/domain/models/notes/modify_notes.dart';
import 'package:encrypted_notes/domain/models/failedDeletedNotes/failedDeletedNotes.dart';
import 'package:encrypted_notes/domain/models/notes/notes.dart';
import 'package:encrypted_notes/domain/models/request_status.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_local_repository.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_remote_repository.dart';
import 'package:encrypted_notes/domain/repositories/secret_shared_preferences_repository.dart';
import 'package:encrypted_notes/domain/repositories/synced_client_repository_local.dart';
import 'package:encrypted_notes/domain/repositories/user_local_repository.dart';
import 'package:encrypted_notes/domain/usecases/encryption/message_encryption_use_case.dart';
import 'package:encrypted_notes/domain/usecases/notes/util/load_notes/get_un_synced_for_this_device_id.dart';
import 'package:encrypted_notes/domain/usecases/notes/util/load_notes/is_note_un_synced_for_this_device.dart';

class GetNotesResponse {
  final Stream<List<EncryptedNote>> localNotesStream;
  final Stream<RequestStatus> loadingNotesFromServerStatus;

  GetNotesResponse({
    required this.loadingNotesFromServerStatus,
    required this.localNotesStream,
  });
}

enum GetNotesErrorCodes { unexpected, network }

enum LoadByIdErrorCodes { noteNotExist, unexpected }

class LoadNoteUseCase {
  LoadNoteUseCase({
    required ModifyNoteLocalRepository modifyNoteRepository,
    required ModifyNoteRemoteRepository modifyNoteRemoteRepository,
    required NotesMapper notesMapper,
    required SecretSharedPreferencesRepository
        secretSharedPreferencesRepository,
    required MessageEncryptionUseCase messageEncryptionUseCase,
    required RemoteDeviceRepositoryLocal remoteDeviceRepositoryLocal,
    required UserLocalRepository userLocalRepository,
  })  : _modifyNoteLocalRepository = modifyNoteRepository,
        _modifyNoteRemoteRepository = modifyNoteRemoteRepository,
        _notesMapper = notesMapper,
        _secretSharedPreferencesRepository = secretSharedPreferencesRepository,
        _messageEncryptionUseCase = messageEncryptionUseCase,
        _remoteDeviceRepositoryLocal = remoteDeviceRepositoryLocal,
        _userLocalRepository = userLocalRepository;

  final ModifyNoteLocalRepository _modifyNoteLocalRepository;
  final ModifyNoteRemoteRepository _modifyNoteRemoteRepository;
  final NotesMapper _notesMapper;
  final SecretSharedPreferencesRepository _secretSharedPreferencesRepository;
  final MessageEncryptionUseCase _messageEncryptionUseCase;
  final RemoteDeviceRepositoryLocal _remoteDeviceRepositoryLocal;
  final UserLocalRepository _userLocalRepository;

  GetNotesResponse getNotes() {
    return GetNotesResponse(
      localNotesStream: _modifyNoteLocalRepository.getNotes(),
      loadingNotesFromServerStatus: _getLoadingNotesFromServer(),
    );
  }

  Future<Either<AppError<LoadByIdErrorCodes>, DecryptedNote>> loadNoteById(
      int noteId) async {
    try {
      final loadedNote = await _modifyNoteLocalRepository.getNoteById(noteId);
      if (loadedNote == null) {
        return left(
          AppError(
            code: LoadByIdErrorCodes.noteNotExist,
            message: "can't find note",
          ),
        );
      }

      final localSecretKey =
          await _secretSharedPreferencesRepository.getLocalSymmetricKey();
      final String decryptedMessage =
          await _messageEncryptionUseCase.decryptMessageForLocal(
        loadedNote.message,
        localSecretKey,
      );

      return right(_notesMapper.encryptedNoteToDecryptedNote(
          loadedNote, decryptedMessage));
    } catch (e) {
      return left(
        AppError(
          code: LoadByIdErrorCodes.unexpected,
          message: e.toString(),
        ),
      );
    }
  }

  Stream<RequestStatus> _getLoadingNotesFromServer() async* {
    yield RequestStatus.loading;
    try {
      late List<GetAllNotesResponse> notesFromServer;
      late List<EncryptedNote> unSyncedNotesForThisDevice;
      late List<FailedDeletedNote> failedDeletedNotes;
      late List<GetRemovingNotesResponse> removedNotesFromServer;
      final deviceId = _userLocalRepository.getUser()!.deviceId;

      await Future.wait([
        _modifyNoteRemoteRepository
            .getNotes()
            .then((value) => notesFromServer = value),
        _modifyNoteLocalRepository
            .getAllFailedDeletedNote()
            .then((value) => failedDeletedNotes = value),
        _modifyNoteRemoteRepository
            .getRemovingNotes()
            .then((value) => removedNotesFromServer = value)
            .catchError((err) => removedNotesFromServer = List.empty()),
        _modifyNoteLocalRepository
            .getNotesWhichHasUnSyncedDevice()
            .then((value) {
          unSyncedNotesForThisDevice =
              getUnSyncedForSpecificDevice(deviceId, value);
        }),
      ]);

      List<NotesCompanion> notesForUpdating = await _getNotesForUpdating(
        notesFromServer,
        failedDeletedNotes,
        unSyncedNotesForThisDevice,
      );
      await _modifyNoteLocalRepository
          .replaceLocalNotesWithRemote(notesForUpdating);

      final List<String> notesIdForRemoving =
          await _getNotesIdForConfirmRemoving(removedNotesFromServer);

      if (notesIdForRemoving.isNotEmpty) {
        await _modifyNoteRemoteRepository
            .confirmRemovingNoteFromDevice(notesIdForRemoving);
      }
      yield RequestStatus.success;
    } on RemoteRepositoryError catch (e) {
      yield RequestStatus.failed;
      throw AppError(code: GetNotesErrorCodes.network, message: e.message);
    } catch (e) {
      yield RequestStatus.failed;
      throw AppError(
        code: GetNotesErrorCodes.unexpected,
        message: "Unexpected error happens",
      );
    }
  }

  Future<List<String>> _getNotesIdForConfirmRemoving(
      List<GetRemovingNotesResponse> removedNotesFromServer) async {
    final List<String> deletedNoteSync = [];
    for (var deletedNote in removedNotesFromServer) {
      final isSuccess = await _modifyNoteLocalRepository
          .deleteNoteByGlobalId(deletedNote.noteGlobalId);

      if (isSuccess == true) {
        deletedNoteSync.add(deletedNote.noteGlobalId);
      }
    }

    return deletedNoteSync;
  }

  Future<List<NotesCompanion>> _getNotesForUpdating(
    List<GetAllNotesResponse> notesFromServer,
    List<FailedDeletedNote> failedDeletedNotes,
    List<EncryptedNote> unSyncedNotesForThisDevice,
  ) async {
    final notesForUpdating = await Future.wait(
      notesFromServer.map((data) async {
        final device = await _remoteDeviceRepositoryLocal
            .getRemoteDeviceById(data.sendFromDeviceId);

        if (device == null) {
          // TODO можливо спробувати запитати в сервера remoteDevice
          return null;
        }

        final decryptedTitle = await _messageEncryptionUseCase
            .decryptMessageE2E(data.title, device.devicePublicKey);

        final decryptedMessage = await _messageEncryptionUseCase
            .decryptMessageE2E(data.message, device.devicePublicKey);

        final localSecretKey =
            await _secretSharedPreferencesRepository.getLocalSymmetricKey();

        final encryptedMessageLocal = await _messageEncryptionUseCase
            .encryptMessageForLocal(decryptedMessage, localSecretKey);

        final isFailedDeleted = failedDeletedNotes
            .any((element) => element.noteGlobalId == data.noteGlobalId);

        final isNoteUnSynced = isNoteUnSyncedForThisDevice(
          unSyncedNotesForThisDevice,
          data.noteGlobalId,
        );
        // ** If we have conflict between local and remote don't override local data
        if (isNoteUnSynced || isFailedDeleted) {
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
    return notesForUpdating
        .where((element) => element != null)
        .toList()
        .cast<NotesCompanion>();
  }
}
