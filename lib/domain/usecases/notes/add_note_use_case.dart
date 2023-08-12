import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:encrypted_notes/data/database/dao/notes_dao.dart';
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

      await _modifyNoteLocalRepository.addSyncingDeviceForNote(
        remoteNote.syncedDevices
            .map((device) => SyncedDeviceProps(
                  deviceId: device.deviceId,
                  noteId: remoteNote.id,
                  isSynced: false,
                ))
            .toList(),
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
      List<AddNotesResponse> response, int noteId) async {
    // TODO write transaction
    print("start transaction");

    await _modifyNoteLocalRepository.updateSyncingDeviceForNote(
      response
          .map((device) => SyncedDeviceProps(
                deviceId: device.deviceId,
                noteId: noteId,
                isSynced: device.isSuccess,
              ))
          .toList(),
    );
  }
}
