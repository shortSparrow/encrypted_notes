import 'package:drift/drift.dart';

@DataClassName("NoteDb")
class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get globalId => integer().nullable()();
  TextColumn get message => text()();
  TextColumn get createdAt => text()
      .clientDefault(() => DateTime.now().millisecondsSinceEpoch.toString())();
  TextColumn get updatedAt => text()
      .clientDefault(() => DateTime.now().millisecondsSinceEpoch.toString())();

  // Add a TextColumn to store the JSON-encoded list of synced devices.
  TextColumn get syncedDevicesJson =>
      text().withDefault(const Constant('[]'))();
}
