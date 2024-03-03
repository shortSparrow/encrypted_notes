import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/domain/models/notes/notes.dart';

abstract class ModifyNoteLocalRepository {
  Future<int> addNote(NotesCompanion note);
  Future<bool> editNote(NotesCompanion note);
  Future<bool> deleteNote(int noteId);
  Stream<List<EncryptedNote>> getNotes();
  Future<EncryptedNote?> getNoteById(int id);

  Future updateSyncingDeviceForNote(
    String syncedDevicesJson,
    int noteId,
  );
  Future<bool> addGlobalIdToNote(String globalId, int noteId);
}
