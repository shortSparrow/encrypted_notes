import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:encrypted_notes/data/database/tables/note_syncing.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'package:encrypted_notes/data/database/tables/notes.dart';

import 'dao/notes_dao.dart';

part 'database.g.dart';

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

@DriftDatabase(tables: [Notes, SyncingNote], daos: [NotesDao])
class AppDatabase extends _$AppDatabase {
  // we tell the database where to store the data with this constructor
  AppDatabase() : super(_openConnection());


  static AppDatabase? _instance;

  static AppDatabase getInstance() {
    if (_instance != null) {
      return _instance as AppDatabase;
    }
    final instance = AppDatabase();
    _instance = instance;
    return instance;
  }

  @override
  int get schemaVersion => 1;

//   Future<List<Note>> get allNoteEntries => select(notes).get();

//   Stream<List<Note>> watchEntriesInNote(Note c) {
//     return (select(notes)..where((t) => t.id.equals(c.id))).watch();
//   }

//   Future<List<Note>> limitNotes(int limit, int offset) {
//     return (select(notes)..limit(limit, offset: offset)).get();
//   }

// // ************************************************************************

// // delete
//   Future removeNote(int id) {
//     return (delete(notes)..where((tbl) => tbl.id.equals(id))).go();
//   }

//   Future updateNote(Note note) {
//     return update(notes).replace(note);
//   }

//   Future updateNoteMessage(int id, String message) {
//     return (update(notes)..where((tbl) => tbl.id.equals(id)))
//         .write(NotesCompanion(message: Value(message)));
//   }

// // ************************************************************************
// // Deferring get vs watch

// // Exposes `get` and `watch`
//   MultiSelectable<Note> pageOfNotes(int page, {int pageSize = 10}) {
//     return select(notes)..limit(pageSize, offset: page);
//   }

// // Exposes `getSingle` and `watchSingle`
//   SingleSelectable<Note> entryById(int id) {
//     return select(notes)..where((t) => t.id.equals(id));
//   }

// // Exposes `getSingleOrNull` and `watchSingleOrNull`
//   SingleOrNullSelectable<Note> entryFromExternalLink(int id) {
//     return select(notes)..where((t) => t.id.equals(id));
//   }

//   // ************************************************************************
}
