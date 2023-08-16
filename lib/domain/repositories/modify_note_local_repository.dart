import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/domain/models/notes.dart';

abstract class ModifyNoteLocalRepository {
  Future<int> addNote(NotesCompanion note);
  Future<bool> editNote(NotesCompanion note);
  Future<bool> deleteNote(int noteId);
  Stream<List<Note>> getNotes();
  Future<Note?> getNoteById(int id);

  Future updateSyncingDeviceForNote(
    String syncedDevicesJson,
    int noteId,
  );
  Future<bool> addGlobalIdToNote(int globalId, int noteId);
}
