import 'package:drift/drift.dart';
import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/domain/models/notes.dart';

class NotesMapper {
  Note dbNoteToNote(NoteDb noteDb) {
    return Note(
      message: noteDb.message,
      createdAt: noteDb.createdAt,
      updatedAt: noteDb.updatedAt,
      id: noteDb.id,
      syncedDevices: [],
    );
  }

  // NotesCompanion noteToDbNote(Note note) {
  //   return NotesCompanion(
  //     message: Value(note.message),
  //     createdAt: Value(note.createdAt),
  //     updatedAt: Value(note.updatedAt),
  //   );
  // }
}
