import 'dart:async';
import 'dart:convert';
import 'package:encrypted_notes/data/mapper/notes_mapper.dart';

import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/data/repositories/shared_preferences/secret_shared_preferences_repository_impl.dart';
import 'package:encrypted_notes/domain/failures/remote_repository_failures.dart';
import 'package:encrypted_notes/domain/models/notes/modify_notes.dart';
import 'package:encrypted_notes/domain/failures/failures.dart';
import 'package:encrypted_notes/domain/models/combined_local_remote_response/combined_local_remote_response.dart';
import 'package:encrypted_notes/domain/models/notes/notes.dart';
import 'package:encrypted_notes/domain/models/remote_device/remote_device.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_local_repository.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_remote_repository.dart';
import 'package:encrypted_notes/domain/repositories/secret_shared_preferences_repository.dart';
import 'package:encrypted_notes/domain/repositories/synced_client_repository_local.dart';
import 'package:encrypted_notes/domain/usecases/encryption/message_encryption_use_case.dart';
import 'package:encrypted_notes/domain/usecases/notes/get_user_remote_devices.dart';
import 'package:encrypted_notes/domain/usecases/notes/util/modify_note/prepare_synchronize_remote_response.dart';

enum LocalAddErrorCodes { noSymmetricKey, unexpectedError }

enum RemoteAddErrorCodes {
  localMessageWasNotSaved,
  syncedDeviceListEmpty,
  remoteError,
  unexpectedError
}

typedef LocalAddResponse = Either<AppError<LocalAddErrorCodes>, int>;
typedef RemoteAddResponse = Either<AppError<RemoteAddErrorCodes>, Unit>;
typedef AddNoteResponse = Future<
    CombinedLocalRemoteResponse<Future<LocalAddResponse>,
        Future<RemoteAddResponse>>>;

class AddNoteUseCase {
  AddNoteUseCase({
    required ModifyNoteLocalRepository modifyNoteLocalRepository,
    required ModifyNoteRemoteRepository modifyNoteRemoteRepository,
    required MessageEncryptionUseCase messageEncryptionUseCase,
    required SecretSharedPreferencesRepository
        secretSharedPreferencesRepository,
    required NotesMapper notesMapper,
    required RemoteDeviceRepositoryLocal remoteDeviceRepositoryLocal,
    required GetUserRemoteDevicesUseCase getUserDevicesUseCase,
  })  : _modifyNoteLocalRepository = modifyNoteLocalRepository,
        _modifyNoteRemoteRepository = modifyNoteRemoteRepository,
        _messageEncryptionUseCase = messageEncryptionUseCase,
        _secretSharedPreferencesRepository = secretSharedPreferencesRepository,
        _notesMapper = notesMapper,
        _getUserDevicesUseCase = getUserDevicesUseCase;

  final ModifyNoteLocalRepository _modifyNoteLocalRepository;
  final ModifyNoteRemoteRepository _modifyNoteRemoteRepository;
  final NotesMapper _notesMapper;
  final MessageEncryptionUseCase _messageEncryptionUseCase;
  final SecretSharedPreferencesRepository _secretSharedPreferencesRepository;
  final GetUserRemoteDevicesUseCase _getUserDevicesUseCase;

  final List<SyncedDevice> syncedDeviceList = [];
  final List<RemoteDevice> remoteDeviceList = [];

  AddNoteResponse addNote({
    required String message,
    required String title,
  }) async {
    await _setupSyncedDevices();
    final local = _addNoteLocally(
      message: message,
      title: title,
    );
    return CombinedLocalRemoteResponse(
      local: local,
      remote: local.then((value) => _prepareAndAddNoteRemote(value)),
    );
  }

  Future<void> _setupSyncedDevices() async {
    final remoteDevices = await _getUserDevicesUseCase.getAllUserDevices();

    remoteDevices.fold(
      (error) => null,
      (devices) {
        remoteDeviceList.addAll(devices);
        final syncedDevices = devices
            .map((e) => SyncedDevice(deviceId: e.id, isSynced: false))
            .toList();

        syncedDeviceList.addAll(syncedDevices);
      },
    );
  }

  Future<LocalAddResponse> _addNoteLocally({
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

      final jsonString = jsonEncode(encryptedMessage.toJson());
      final jsonSyncedDevices = jsonEncode(newSyncedDevices);
      final result = await _modifyNoteLocalRepository.addNote(
        NotesCompanion(
          message: Value(jsonString),
          title: Value(title),
          syncedDevicesJson: Value(jsonSyncedDevices),
        ),
      );

      return right(result);
    } on AppError<GetLocalSymmetricKeyErrorCodes> catch (error) {
      switch (error.code) {
        case GetLocalSymmetricKeyErrorCodes.noSecretKey:
          return left(
            AppError(
              code: LocalAddErrorCodes.noSymmetricKey,
              message: "Can't get your encryption key",
            ),
          );
      }
    } catch (error) {
      return left(
        AppError(
          code: LocalAddErrorCodes.unexpectedError,
          message: "Unexpected error: ${error}",
        ),
      );
    }
  }

  Future<RemoteAddResponse> _prepareAndAddNoteRemote(
      LocalAddResponse value) async {
    try {
      return value.fold(
        (error) {
          return left(
            AppError(
              message: "Local message was not saved",
              code: RemoteAddErrorCodes.localMessageWasNotSaved,
            ),
          );
        },
        (id) async {
          if (syncedDeviceList.isEmpty) {
            return left(
              AppError(
                message:
                    "syncedDeviceList is empty. Message saved only locally",
                code: RemoteAddErrorCodes.syncedDeviceListEmpty,
              ),
            );
          }

          final note = await _modifyNoteLocalRepository.getNoteById(id);

          final isNoteExist = note != null;
          if (!isNoteExist) {
            return left(
              AppError(
                message: "can't load local message by id",
                code: RemoteAddErrorCodes.unexpectedError,
              ),
            );
          }

          final localSecretKey =
              await _secretSharedPreferencesRepository.getLocalSymmetricKey();

          final decryptedMessage =
              await _messageEncryptionUseCase.decryptMessageForLocal(
            note.message,
            localSecretKey,
          );

          return _addNoteRemote(
            note: _notesMapper.encryptedNoteToDecryptedNote(
                note, decryptedMessage),
          );
        },
      );
    } catch (e) {
      return left(
        AppError(
          message: e.toString(),
          code: RemoteAddErrorCodes.unexpectedError,
        ),
      );
    }
  }

  Future<RemoteAddResponse> _addNoteRemote({
    required DecryptedNote note,
  }) async {
    try {
      final encryptedData = await _encryptNoteForEachRecipient(note: note);
      final result = await _modifyNoteRemoteRepository.addNote(encryptedData);

      await _synchronizeRemoteResponse(
        result,
        note.id,
      );

      return right(unit);
    } on RemoteRepositoryError catch (e) {
      switch (e) {
        case ParseServerDataError():
        case NetworkError():
          return left(
            AppError(
              message: e.message,
              code: RemoteAddErrorCodes.remoteError,
            ),
          );
      }
    }
  }

  Future<List<NoteDataForServer>> _encryptNoteForEachRecipient({
    required DecryptedNote note,
  }) async {
    final futureEncryptedDeviceList =
        remoteDeviceList.map((remoteDevice) async {
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
    AddNotesResponse response,
    int noteId,
  ) async {
    final note = await _modifyNoteLocalRepository.getNoteById(noteId);
    final updated = prepareSynchronizeRemoteResponse(response.notes, note);
 
    await AppDatabase.getInstance().transaction(() async {
      await _modifyNoteLocalRepository.updateSyncingDeviceForNote(
        jsonEncode(updated),
        noteId,
      );

      await _modifyNoteLocalRepository.addGlobalIdToNote(
        response.noteGlobalId,
        noteId,
      );
    });
  }
}
