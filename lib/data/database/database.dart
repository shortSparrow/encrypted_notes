import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:encrypted_notes/data/database/dao/remote_device_dao.dart';
import 'package:encrypted_notes/data/database/tables/remote_device.dart';
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

@DriftDatabase(tables: [Notes, RemoteDevices], daos: [NotesDao, RemoteDevicesDao])
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

  @override
  MigrationStrategy get migration =>
      MigrationStrategy(beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      });
}
