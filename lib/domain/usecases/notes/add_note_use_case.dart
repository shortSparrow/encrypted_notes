import 'dart:async';
import 'dart:convert';
import 'package:cryptography/cryptography.dart';
import 'package:encrypted_notes/constants/storage_keys.dart';
import 'package:encrypted_notes/data/mapper/notes_mapper.dart';

import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/domain/failures/failures.dart';
import 'package:encrypted_notes/domain/models/combined_local_remote_response/combined_local_remote_response.dart';
import 'package:encrypted_notes/domain/models/notes/notes.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_local_repository.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_remote_repository.dart';
import 'package:encrypted_notes/domain/usecases/notes/encypt_note_use_case.dart';
import 'package:encrypted_notes/domain/usecases/notes/get_synced_device_list.dart';

class AddNoteUseCase {
  AddNoteUseCase({
    required ModifyNoteLocalRepository modifyNoteLocalRepository,
    required ModifyNoteRemoteRepository modifyNoteRemoteRepository,
    required EncryptNoteUseCase encryptNoteUseCase,
    required GetSyncedDeviceListUseCase getSyncedDeviceListUseCase,
    required NotesMapper notesMapper,
  })  : _modifyNoteLocalRepository = modifyNoteLocalRepository,
        _modifyNoteRemoteRepository = modifyNoteRemoteRepository,
        _encryptNoteUseCase = encryptNoteUseCase,
        _getSyncedDeviceListUseCase = getSyncedDeviceListUseCase,
        _notesMapper = notesMapper;

  final ModifyNoteLocalRepository _modifyNoteLocalRepository;
  final ModifyNoteRemoteRepository _modifyNoteRemoteRepository;
  final EncryptNoteUseCase _encryptNoteUseCase;
  final GetSyncedDeviceListUseCase _getSyncedDeviceListUseCase;
  final NotesMapper _notesMapper;

  Future<
      CombinedLocalRemoteResponse<Future<Either<Failure, int>>,
          Future<Either<Failure, bool>>>> addNote({
    required String message,
    required String title,
  }) async {
    final syncedDeviceList =
        await _getSyncedDeviceListUseCase.getSyncedDeviceList();

    final local = _addNoteLocally(
      message: message,
      title: title,
      syncedDeviceList: syncedDeviceList,
    );
    return CombinedLocalRemoteResponse(
      local: local,
      remote: local.then((value) async {
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
                await _encryptNoteUseCase.getLocalSymmetricSecretKey();

            final decryptedMessage = await _encryptNoteUseCase.decryptLocal(
              note.message,
              localSecretKey,
            );

            return _addNoteRemote(
              note: _notesMapper.encryptedNoteToNote(note, decryptedMessage),
            );
          },
        );
      }),
    );
  }

  Future<Either<Failure, int>> _addNoteLocally({
    required String message,
    required String title,
    required List<SyncedDevice> syncedDeviceList,
  }) async {
    try {
      final syncedDevices = syncedDeviceList
          .map((syncedDevice) => syncedDevice.copyWith(isSynced: false))
          .toList();

      final localSecretKey =
          await _encryptNoteUseCase.getLocalSymmetricSecretKey();

      final encryptedMessage = await _encryptNoteUseCase.encryptForLocal(
        message,
        localSecretKey,
      );

      final result = await _modifyNoteLocalRepository.addNote(
        NotesCompanion(
          message: Value(jsonEncode(encryptedMessage.toJson())),
          title: Value(title),
          syncedDevicesJson: Value(jsonEncode(syncedDevices)),
        ),
      );

      return right(result);
    } catch (e) {
      return left(GeneralFailure(message: "local error"));
    }
  }

  Future<Either<Failure, bool>> _addNoteRemote({
    required Note note,
  }) async {
    try {
      final encryptedData = await _getEncryptedNotes(note);
      final result = await _modifyNoteRemoteRepository.addNotes(encryptedData);

      await _synchronizeRemoteResponse(
        result.addNotesDeviceInfoResponse,
        note.id,
        result.globalId,
      );
      return right(true);
    } catch (e) {
      return left(GeneralFailure(message: "remote error"));
    }
  }

  Future<List<NoteDataForServer>> _getEncryptedNotes(Note note) async {
    final futureEncryptedDeviceList =
        note.syncedDevices.map((_syncedDevice) async {
      final encryptedData = await _encryptNoteUseCase.encryptForServer(
        note.title,
        note.message,
        _syncedDevice.devicePublicKey,
      );

      return NoteDataForServer(
        metaData: NoteDataForServerMetaData(
          createdAt: note.createdAt,
          updatedAt: note.updatedAt,
          sendToDevice: _syncedDevice.deviceId,
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
    List<AddNotesDeviceInfoResponse> response,
    int noteId,
    int globalId,
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

      await _modifyNoteLocalRepository.addGlobalIdToNote(globalId, noteId);
    });
  }
}
