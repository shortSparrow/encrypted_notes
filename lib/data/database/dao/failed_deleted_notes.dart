import 'package:drift/drift.dart';
import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/data/database/tables/failedDeletedNotes.dart';
part 'failed_deleted_notes.g.dart';

@DriftAccessor(tables: [FailedDeletedNotes])
class FailedDeletedNotesDao extends DatabaseAccessor<AppDatabase>
    with _$FailedDeletedNotesDaoMixin {
  FailedDeletedNotesDao(AppDatabase db) : super(db);

  Future<int> addFailedRemoteDeletedNote(
      FailedDeletedNotesCompanion failedDeleted) {
    return into(failedDeletedNotes)
        .insert(failedDeleted, mode: InsertMode.insertOrReplace);
  }

  Future deleteFailedRemoteDeletedNote(List<String> noteGlobalIds) async {
    await (delete(failedDeletedNotes)
          ..where((t) => t.noteGlobalId.isIn(noteGlobalIds)))
        .go();
  }

  Future<List<FailedDeletedNotesDb>> getAllFailedDeletedNote() {
    return select(failedDeletedNotes).get();
  }
}
