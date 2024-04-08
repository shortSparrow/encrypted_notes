import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/domain/models/failedDeletedNotes/failedDeletedNotes.dart';
import 'package:encrypted_notes/domain/models/notes/notes.dart';

abstract class ModifyNoteLocalRepository {
  Future<int> addNote(NotesCompanion note);
  Future<bool> editNote(NotesCompanion note);
  Future<int> addFailedRemoteDeletedNote(FailedDeletedNotesCompanion failedDeleted);
  Future removeFailedRemoteDeletedNote(List<String> globalNoteId);
  Future<List<FailedDeletedNote>> getAllFailedDeletedNote();
  Future<bool> deleteNote(int noteId);
  Future<bool> deleteNoteByGlobalId(String noteGlobalId);
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
