import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/domain/failures/failures.dart';
import 'package:encrypted_notes/domain/models/comnied_local_remote_response.dart';
import 'package:encrypted_notes/domain/models/notes.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_local_repository.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_remote_repository.dart';

class AddNoteUseCase {
  AddNoteUseCase({
    required ModifyNoteLocalRepository modifyNoteLocalRepository,
    required ModifyNoteRemoteRepository modifyNoteRemoteRepository,
  })  : _modifyNoteLocalRepository = modifyNoteLocalRepository,
        _modifyNoteRemoteRepository = modifyNoteRemoteRepository;

  final ModifyNoteLocalRepository _modifyNoteLocalRepository;
  final ModifyNoteRemoteRepository _modifyNoteRemoteRepository;

  CombinedLocalRemoteResponse<Future<Either<Failure, bool>>,
      Future<Either<Failure, bool>>> addNote(NotesCompanion note) {
    return CombinedLocalRemoteResponse(
      local: _addNoteLocally(
        note,
        Note(
          message: note.message.value,
          createdAt: "111",
          updatedAt: "111",
          id: 1,
          syncedDevices: [
            SyncedDevice(deviceId: "device_id_1", isSynced: false),
            SyncedDevice(deviceId: "device_id_2", isSynced: false),
            SyncedDevice(deviceId: "device_id_3", isSynced: false)
          ],
        ),
      ),
      remote: _addNoteRemote(
        Note(
          message: note.message.value,
          createdAt: "111",
          updatedAt: "111",
          id: 1,
          syncedDevices: [
            SyncedDevice(deviceId: "device_id_1", isSynced: false),
            SyncedDevice(deviceId: "device_id_2", isSynced: false),
            SyncedDevice(deviceId: "device_id_3", isSynced: false)
          ],
        ),
      ),
    );
  }

  Future<Either<Failure, bool>> _addNoteLocally(
      NotesCompanion note, Note remoteNote) async {
    try {
      await _modifyNoteLocalRepository.addNote(note);
      await _modifyNoteLocalRepository.updateSyncingDeviceForNote(
        jsonEncode(remoteNote.syncedDevices),
        remoteNote.id,
      );

      return right(true);
    } catch (e) {
      return left(GeneralFailure(message: "local error"));
    }
  }

  List<NoteDataForServer> _getEncryptedNotes(Note note) {
    return [
      NoteDataForServer(
        createdAt: note.createdAt,
        updatedAt: note.updatedAt,
        id: note.id,
        message: note.message,
        sendToDevice: note.syncedDevices[0].deviceId,
      ),
      NoteDataForServer(
        createdAt: note.createdAt,
        updatedAt: note.updatedAt,
        id: note.id,
        message: note.message,
        sendToDevice: note.syncedDevices[1].deviceId,
      ),
      NoteDataForServer(
        createdAt: note.createdAt,
        updatedAt: note.updatedAt,
        id: note.id,
        message: note.message,
        sendToDevice: note.syncedDevices[2].deviceId,
      ),
    ];
  }

  Future<Either<Failure, bool>> _addNoteRemote(Note note) async {
    try {
// TODO get all pulic keys (probably hive)
// TODO encypt note

      await Future.delayed(Duration(seconds: 3));
      final result =
          await _modifyNoteRemoteRepository.addNotes(_getEncryptedNotes(note));

      await _synchronizeRemoteResponse(result, note.id);
      return right(true);
    } catch (e) {
      return left(GeneralFailure(message: "remote error"));
    }
  }

  Future _synchronizeRemoteResponse(
    List<AddNotesResponse> response,
    int noteId,
  ) async {
    final syncingDeviceStatusList = response
        .map((item) =>
            SyncedDevice(deviceId: item.deviceId, isSynced: item.isSuccess))
        .toList();

    await _modifyNoteLocalRepository.updateSyncingDeviceForNote(
        jsonEncode(syncingDeviceStatusList), noteId);
  }
}
