import 'package:drift/drift.dart';
import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/data/database/tables/notes.dart';
part 'notes_dao.g.dart';

@DriftAccessor(tables: [Notes])
class NotesDao extends DatabaseAccessor<AppDatabase> with _$NotesDaoMixin {
  NotesDao(AppDatabase db) : super(db);

  MultiSelectable<NoteDb> getNotes() {
    return select(notes);
  }

  Future<List<NoteDb>> getNotesWhichHasUnSyncedDevice() {
    return (select(notes)
          ..where((tbl) => tbl.syncedDevicesJson.contains('"isSynced":false')))
        .get();
  }

  Future<NoteDb?> getNoteById(int noteId) {
    return (select(notes)..where((tbl) => tbl.id.equals(noteId)))
        .getSingleOrNull();
  }

  Future<NoteDb?> getNoteByGlobalId(String globalId) {
    return (select(notes)..where((tbl) => tbl.noteGlobalId.equals(globalId)))
        .getSingleOrNull();
  }

  Future<int> addNote(NotesCompanion note) {
    return into(notes).insert(note);
  }

  Future<int> addGlobalIdToNote(String noteGlobalId, int noteId) {
    return (update(notes)..where((tbl) => tbl.id.equals(noteId)))
        .write(NotesCompanion(noteGlobalId: Value(noteGlobalId)));
  }

  Future<bool> editNote(NotesCompanion note) {
    return update(notes).replace(note);
  }

  Future<int> deleteNote(int noteId) {
    return (delete(notes)..where((tbl) => tbl.id.equals(noteId))).go();
  }

  Future<int> deleteNoteByGlobalId(String noteGlobalId) {
    return (delete(notes)..where((tbl) => tbl.noteGlobalId.equals(noteGlobalId))).go();
  }

  Future deleteAllNotes() {
    return delete(notes).go();
  }

  Future<int> updateSyncingDeviceForNote(String syncedDevicesJson, int noteId) {
    return (update(notes)..where((tbl) => tbl.id.equals(noteId)))
        .write(NotesCompanion(syncedDevicesJson: Value(syncedDevicesJson)));
  }
}
