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

  Future<NoteDb?> getNoteById(int noteId) {
    return (select(notes)..where((tbl) => tbl.id.equals(noteId)))
        .getSingleOrNull();
  }

  Future<int> addNote(NotesCompanion note) {
    return into(notes).insert(note);
  }

  Future<int> addGlobalIdToNote(String globalId, int noteId) {
    return (update(notes)..where((tbl) => tbl.id.equals(noteId)))
        .write(NotesCompanion(globalId: Value(globalId)));
  }

  Future<bool> editNote(NotesCompanion note) {
    return update(notes).replace(note);
  }

  Future<int> deleteNote(int noteId) {
    return (delete(notes)..where((tbl) => tbl.id.equals(noteId))).go();
  }

// FIXME current problem, if server return me different device id, I just ovveride my loca id and lost info about synchronizing
  Future<int> updateSyncingDeviceForNote(String syncedDevicesJson, int noteId) {
    // TODO right now I just override whole raw with values from server. Maybe would be better to get current syncedDevicesJson, update them using new values from server and then update database
    return (update(notes)..where((tbl) => tbl.id.equals(noteId)))
        .write(NotesCompanion(syncedDevicesJson: Value(syncedDevicesJson)));
  }
}
