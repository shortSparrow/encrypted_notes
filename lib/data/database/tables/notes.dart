import 'package:drift/drift.dart';

import 'note_syncing.dart';

@DataClassName("NoteDb")
class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get message => text()();
  TextColumn get createdAt => text()
      .clientDefault(() => DateTime.now().millisecondsSinceEpoch.toString())();
  TextColumn get updatedAt => text()
      .clientDefault(() => DateTime.now().millisecondsSinceEpoch.toString())();
}
