import 'dart:convert';

import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/domain/models/notes/notes.dart';

class NotesMapper {
  Note dbNoteToNote(NoteDb noteDb) {
    // TODO find better way
    List<SyncedDevice> syncedDevices = [];

    final List<dynamic> jsonList = jsonDecode(noteDb.syncedDevicesJson);

    for (var e in jsonList) {
      syncedDevices.add(SyncedDevice.fromJson(e));
    }

    return Note(
      message: noteDb.message,
      title: noteDb.title,
      createdAt: noteDb.createdAt,
      updatedAt: noteDb.updatedAt,
      id: noteDb.id,
      syncedDevices: syncedDevices,
      globalId: noteDb.globalId,
    );
  }

  EncryptedNote dbNoteToEncryptedNote(NoteDb noteDb) {
    List<SyncedDevice> syncedDevices = [];

    final List<dynamic> jsonList = jsonDecode(noteDb.syncedDevicesJson);

    for (var e in jsonList) {
      syncedDevices.add(SyncedDevice.fromJson(e));
    }

    final message = EncryptedMessage.fromJson(jsonDecode(noteDb.message));

    return EncryptedNote(
        message: message,
        title: noteDb.title,
        createdAt: noteDb.createdAt,
        updatedAt: noteDb.updatedAt,
        id: noteDb.id,
        syncedDevices: syncedDevices,
        globalId: noteDb.globalId);
  }

  Note encryptedNoteToNote(
      EncryptedNote encryptedNote, String decryptedMessage) {
    return Note(
      title: encryptedNote.title,
      message: decryptedMessage,
      createdAt: encryptedNote.createdAt,
      updatedAt: encryptedNote.updatedAt,
      id: encryptedNote.id,
      globalId: encryptedNote.globalId,
      syncedDevices: encryptedNote.syncedDevices,
    );
  }

  NoteDataForServerData noteDataForServerEncryptedDataToNoteDataForServerData(
      NoteDataForServerEncryptedData data) {
    return NoteDataForServerData(message: data.message, title: data.title);
  }
}
