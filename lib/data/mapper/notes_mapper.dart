import 'dart:convert';

import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/domain/models/notes.dart';

class NotesMapper {
  Note dbNoteToNote(NoteDb noteDb) {
    return Note(
        message: noteDb.message,
        title: noteDb.title,
        createdAt: noteDb.createdAt,
        updatedAt: noteDb.updatedAt,
        id: noteDb.id,
        syncedDevices: (jsonDecode(noteDb.syncedDevicesJson) as Iterable)
            .map((e) => SyncedDevice.fromJson(e))
            .toList());
  }

  List<NoteDataForServer> noteCompanionToNoteDataForServer(
      NotesCompanion noteCompanion) {
    final syncedDeviceList =
        (jsonDecode(noteCompanion.syncedDevicesJson.value) as Iterable)
            .map((e) => SyncedDevice.fromJson(e))
            .toList();

    return syncedDeviceList
        .map(
          (syncedDevice) => NoteDataForServer(
            message: noteCompanion.message.value,
            title: noteCompanion.title.value,
            createdAt: noteCompanion.createdAt.value,
            updatedAt: noteCompanion.updatedAt.value,
            sendToDevice: syncedDevice.deviceId,
          ),
        )
        .toList();
  }

  // NotesCompanion noteToDbNote(Note note) {
  //   return NotesCompanion(
  //     message: Value(note.message),
  //     createdAt: Value(note.createdAt),
  //     updatedAt: Value(note.updatedAt),
  //   );
  // }
}
