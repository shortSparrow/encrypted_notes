import 'package:drift/drift.dart';

@DataClassName("RemoteDeviceDb")
class RemoteDevices extends Table {
  TextColumn get id => text()();
  IntColumn get userId => integer()();
  TextColumn get deviceName => text().nullable()();
  TextColumn get systemVersion => text().nullable()();
  TextColumn get devicePublicKey => text()();

  @override
  Set<Column> get primaryKey => {id};
}
