import 'package:drift/drift.dart';

@DataClassName("NoteDb")
class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get message => text()();
  TextColumn get createdAt => text()
      .clientDefault(() => DateTime.now().millisecondsSinceEpoch.toString())();
  TextColumn get updatedAt => text()
      .clientDefault(() => DateTime.now().millisecondsSinceEpoch.toString())();
}
