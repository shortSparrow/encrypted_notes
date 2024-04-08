import 'package:drift/drift.dart';

@DataClassName("FailedDeletedNotesDb")
class FailedDeletedNotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get noteId => integer()();
  TextColumn get noteGlobalId => text().nullable()();
}
