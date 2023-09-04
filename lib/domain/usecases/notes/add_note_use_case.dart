import 'dart:async';
import 'dart:convert';
import 'package:cryptography/cryptography.dart';
import 'package:cryptography_flutter/cryptography_flutter.dart';
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

class AddNoteUseCase {
  AddNoteUseCase({
    required ModifyNoteLocalRepository modifyNoteLocalRepository,
    required ModifyNoteRemoteRepository modifyNoteRemoteRepository,
    required EncryptNoteUseCase encryptNoteUseCase,
    required NotesMapper notesMapper,
  })  : _modifyNoteLocalRepository = modifyNoteLocalRepository,
        _modifyNoteRemoteRepository = modifyNoteRemoteRepository,
        _encryptNoteUseCase = encryptNoteUseCase,
        _notesMapper = notesMapper;

  final ModifyNoteLocalRepository _modifyNoteLocalRepository;
  final ModifyNoteRemoteRepository _modifyNoteRemoteRepository;
  final EncryptNoteUseCase _encryptNoteUseCase;
  final NotesMapper _notesMapper;

  CombinedLocalRemoteResponse<Future<Either<Failure, int>>,
      Future<Either<Failure, bool>>> addNote({
    required String message,
    String title = "unknown",
    required List<String> deviceIdList,
  }) {
    final local = _addNoteLocally(
      message: message,
      title: title,
      deviceIdList: deviceIdList,
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
            return _addNoteRemote(deviceIdList: deviceIdList, note: note);
          },
        );
      }),
    );
  }

  Future<Either<Failure, int>> _addNoteLocally({
    required String message,
    required String title,
    required List<String> deviceIdList,
  }) async {
    try {
      final syncedDevices = deviceIdList
          .map((deviceId) => SyncedDevice(deviceId: deviceId, isSynced: false))
          .toList();
      final result = await _modifyNoteLocalRepository.addNote(
        NotesCompanion(
          message: Value(message),
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
    required List<String> deviceIdList,
  }) async {
    try {
      final algorithm = X25519();
      final _keyPair = await algorithm.newKeyPair();
      final recipientPublicKey = await _keyPair.extractPublicKey();
// TODO JUST for demo
      await _encryptNoteUseCase.encryptForServer(
        NoteDataForServerData(title: note.title, message: note.message),
        recipientPublicKey,
      );

      final result =
          await _modifyNoteRemoteRepository.addNotes(_getEncryptedNotes(note));

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

  List<NoteDataForServer> _getEncryptedNotes(Note note) {
    return note.syncedDevices.map((_syncedDevice) {
      return NoteDataForServer(
        metaData: NoteDataForServerMetaData(
          createdAt: note.createdAt,
          updatedAt: note.updatedAt,
          sendToDevice: _syncedDevice.deviceId,
        ),
        data: NoteDataForServerData(title: note.title, message: note.message),
      );
    }).toList();
  }

  Future _synchronizeRemoteResponse(
    List<AddNotesDeviceInfoResponse> response,
    int noteId,
    int globalId,
  ) async {
    final syncingDeviceStatusList = response
        .map((item) =>
            SyncedDevice(deviceId: item.deviceId, isSynced: item.isSuccess))
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
