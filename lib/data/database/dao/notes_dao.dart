import 'package:drift/drift.dart';
import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/data/database/tables/note_syncing.dart';
import 'package:encrypted_notes/data/database/tables/notes.dart';
import 'package:encrypted_notes/domain/models/notes.dart';
part 'notes_dao.g.dart';

class SyncedDeviceProps {
  final int noteId;
  final String deviceId;
  final bool isSynced;
  SyncedDeviceProps(
      {required this.noteId, required this.deviceId, required this.isSynced});
}

@DriftAccessor(tables: [Notes, SyncingNote])
class NotesDao extends DatabaseAccessor<AppDatabase> with _$NotesDaoMixin {
  NotesDao(AppDatabase db) : super(db);

  MultiSelectable<NoteDb> getNotes() {
    return select(notes);
  }

  Stream<List<Note>> getNotesWatch() async* {
    await customStatement('PRAGMA foreign_keys = ON');

    yield* select(notes).watch().asyncMap(
      (event) async {
        final data = event.map((e) async {
          final syncedDevices = await (select(syncingNote)
                ..where((tbl) => tbl.noteId.equals(e.id)))
              .get();
          print("syncedDevices ${syncedDevices}");

          return Note(
            message: e.message,
            createdAt: e.createdAt,
            updatedAt: e.updatedAt,
            id: e.id,
            syncedDevices: syncedDevices
                .map(
                  (e) =>
                      SyncedDevice(deviceId: e.deviceId, isSynced: e.isSynced),
                )
                .toList(),
          );
        });
        return Future.wait(data);
      },
    );
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

  Future<List<SyncingNoteData>> getSyncingDeviceForNote(int noteId) {
    return (select(syncingNote)..where((tbl) => tbl.noteId.equals(noteId)))
        .get();
  }

  Future addSyncingDeviceForNote(List<SyncedDeviceProps> data) {
    return transaction(() async {
      for (var item in data) {
        final existingRow = await (select(syncingNote)
              ..where(
                (tbl) =>
                    tbl.noteId.equals(item.noteId) &
                    tbl.deviceId.equals(item.deviceId),
              ))
            .getSingleOrNull();

        if (existingRow == null) {
          await into(syncingNote).insertOnConflictUpdate(
            SyncingNoteCompanion(
              isSynced: Value(item.isSynced),
              deviceId: Value(item.deviceId),
              noteId: Value(item.noteId),
            ),
          );
        } else {
          await updateSyncingDeviceForNote([item]);
        }
      }
    });
  }

  Future updateSyncingDeviceForNote(List<SyncedDeviceProps> data) {
    return transaction(() async {
      for (var item in data) {
        await (update(syncingNote)
              ..where(
                (tbl) =>
                    tbl.deviceId.equals(item.deviceId) &
                    tbl.noteId.equals(item.noteId),
              ))
            .write(SyncingNoteCompanion(isSynced: Value(item.isSynced)));
      }
    });
  }
}
