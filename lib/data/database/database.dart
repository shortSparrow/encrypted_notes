import 'package:drift/drift.dart';
import 'package:encrypted_notes/data/database/dao/failed_deleted_notes.dart';
import 'package:encrypted_notes/data/database/dao/remote_device_dao.dart';
import 'package:encrypted_notes/data/database/tables/failedDeletedNotes.dart';
import 'package:encrypted_notes/data/database/tables/remote_device.dart';

import 'package:encrypted_notes/data/database/tables/notes.dart';

import 'dao/notes_dao.dart';
import './open_connection/open_connection_impl.dart'
    if (dart.library.js) './open_connection/open_connection_web_impl.dart';
part 'database.g.dart';

@DriftDatabase(
    tables: [Notes, RemoteDevices, FailedDeletedNotes],
    daos: [NotesDao, RemoteDevicesDao, FailedDeletedNotesDao])
class AppDatabase extends _$AppDatabase {
  // we tell the database where to store the data with this constructor
  AppDatabase() : super(OpenConnectionImpl().openConnection());

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
