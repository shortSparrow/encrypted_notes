import 'package:drift/drift.dart';
import 'notes.dart';

class SyncingNote extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get deviceId => text()();
  BoolColumn get isSynced => boolean()();
  IntColumn get noteId =>
      integer().customConstraint('NOT NULL REFERENCES notes (id)')();
}
