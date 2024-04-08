import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/domain/models/notes/notes.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_remote_repository.dart';

class NotesMapper {
  DecryptedNote dbNoteToNote(NoteDb noteDb) {
    // TODO find better way
    List<SyncedDevice> syncedDevices = [];

    final List<dynamic> jsonList = jsonDecode(noteDb.syncedDevicesJson);

    for (var e in jsonList) {
      syncedDevices.add(SyncedDevice.fromJson(e));
    }

    return DecryptedNote(
      message: noteDb.message,
      title: noteDb.title,
      createdAt: noteDb.createdAt,
      updatedAt: noteDb.updatedAt,
      id: noteDb.id,
      syncedDevices: syncedDevices,
      noteGlobalId: noteDb.noteGlobalId,
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
      noteGlobalId: noteDb.noteGlobalId,
    );
  }

  DecryptedNote encryptedNoteToDecryptedNote(
      EncryptedNote encryptedNote, String decryptedMessage) {
    return DecryptedNote(
      title: encryptedNote.title,
      message: decryptedMessage,
      createdAt: encryptedNote.createdAt,
      updatedAt: encryptedNote.updatedAt,
      id: encryptedNote.id,
      noteGlobalId: encryptedNote.noteGlobalId,
      syncedDevices: encryptedNote.syncedDevices,
    );
  }

  // NotesCompanion noteToDbNote(EncryptedNote note) {
  //   return NotesCompanion(
  //     title: Value(note.title),
  //     message: Value(jsonEncode(note.message.toJson())),
  //     createdAt: Value(note.createdAt),
  //     updatedAt: Value(note.updatedAt),
  //     id: Value(note.id),
  //     noteGlobalId: Value(note.noteGlobalId),
  //     syncedDevicesJson: Value(jsonEncode(note.syncedDevices)),
  //   );
  // }

  // NotesCompanion getAllNotesResponseToNoteCampaign(GetAllNotesResponse note) {
  //   return NotesCompanion(
  //     noteGlobalId: Value(note.noteGlobalId),
  //     message: Value(jsonEncode(note.message.toJson())),
  //     title: Value(jsonEncode(note.title.toJson())),
  //     createdAt: Value(note.createdAt),
  //     updatedAt: Value(note.updatedAt),
  //   );
  // }

  NoteDataForServerEncryptedData
      noteDataForServerEncryptedDataToNoteDataForServerData(
          NoteDataForServerEncryptedData data) {
    return NoteDataForServerEncryptedData(
        message: data.message, title: data.title);
  }
}
