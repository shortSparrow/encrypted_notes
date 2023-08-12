import 'package:encrypted_notes/data/database/dao/notes_dao.dart';
import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/domain/models/notes.dart';

abstract class ModifyNoteLocalRepository {
  Future<bool> addNote(NotesCompanion note);
  Future<bool> editNote(NotesCompanion note);
  Future<bool> deleteNote(int noteId);
  Stream<List<Note>> getNotes();
  Future<List<SyncingNoteData>> getSyncingDeviceForNote(int noteId);

  Future addSyncingDeviceForNote(List<SyncedDeviceProps> data);
  Future updateSyncingDeviceForNote(List<SyncedDeviceProps> data);
}
