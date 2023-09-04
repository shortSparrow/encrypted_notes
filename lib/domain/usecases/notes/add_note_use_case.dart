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

class AddNoteUseCase {
  AddNoteUseCase({
    required ModifyNoteLocalRepository modifyNoteLocalRepository,
    required ModifyNoteRemoteRepository modifyNoteRemoteRepository,
    required NotesMapper notesMapper,
  })  : _modifyNoteLocalRepository = modifyNoteLocalRepository,
        _modifyNoteRemoteRepository = modifyNoteRemoteRepository,
        _notesMapper = notesMapper;

  final ModifyNoteLocalRepository _modifyNoteLocalRepository;
  final ModifyNoteRemoteRepository _modifyNoteRemoteRepository;
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
    return [
      NoteDataForServer(
        createdAt: note.createdAt,
        updatedAt: note.updatedAt,
        message: note.message,
        sendToDevice: note.syncedDevices[0].deviceId,
        title: note.title,
      ),
      NoteDataForServer(
        createdAt: note.createdAt,
        updatedAt: note.updatedAt,
        message: note.message,
        sendToDevice: note.syncedDevices[1].deviceId,
        title: note.title,
      ),
      NoteDataForServer(
        createdAt: note.createdAt,
        updatedAt: note.updatedAt,
        message: note.message,
        sendToDevice: note.syncedDevices[2].deviceId,
        title: note.title,
      ),
    ];
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
