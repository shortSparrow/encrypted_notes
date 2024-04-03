import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/domain/models/notes/notes.dart';

abstract class ModifyNoteLocalRepository {
  Future<int> addNote(NotesCompanion note);
  Future<bool> editNote(NotesCompanion note);
  Future<bool> deleteNote(int noteId);
  Stream<List<EncryptedNote>> getNotes();
  Future<EncryptedNote?> getNoteById(int id);
  Future<EncryptedNote?> getNoteByGlobalId(String globalId);
  Future<List<EncryptedNote>> getNotesWhichHasUnSyncedDevice();
  Future updateSyncingDeviceForNote(
    String syncedDevicesJson,
    int noteId,
  );
  Future<bool> addGlobalIdToNote(String noteGlobalId, int noteId);
  Future replaceLocalNotesWithRemote(List<NotesCompanion> notes);
}
