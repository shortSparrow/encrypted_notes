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

  Future<int> addNote(NotesCompanion note) {
    return into(notes).insert(note);
  }

  Future<bool> editNote(NotesCompanion note) {
    return update(notes).replace(note);
  }

  Future<int> deleteNote(int noteId) {
    return (delete(notes)..where((tbl) => tbl.id.equals(noteId))).go();
  }
}
