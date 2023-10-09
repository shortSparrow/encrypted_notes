import 'package:drift/drift.dart';
import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/data/database/tables/remote_device.dart';
part 'remote_device_dao.g.dart';

@DriftAccessor(tables: [RemoteDevices])
class RemoteDevicesDao extends DatabaseAccessor<AppDatabase>
    with _$RemoteDevicesDaoMixin {
  RemoteDevicesDao(AppDatabase db) : super(db);

  MultiSelectable<RemoteDeviceDb> getRemoteDevices() {
    return select(remoteDevices);
  }

  Future<RemoteDeviceDb?> getRemoteDeviceById(String deviceId) {
    return (select(remoteDevices)..where((tbl) => tbl.id.equals(deviceId)))
        .getSingleOrNull();
  }

  Future<List<RemoteDeviceDb>> getListRemoteDeviceById(List<String> devicesId) {
    return (select(remoteDevices)..where((tbl) => tbl.id.isIn(devicesId))).get();
  }

  Future addRemoteDevice(RemoteDevicesCompanion remoteDevice) {
    return into(remoteDevices).insert(remoteDevice);
  }

  Future<bool> updateRemoteDevice(RemoteDevicesCompanion remoteDevice) {
    return update(remoteDevices).replace(remoteDevice);
  }

  Future<int> deleteRemoteDevice(String deviceId) {
    return (delete(remoteDevices)..where((tbl) => tbl.id.equals(deviceId)))
        .go();
  }
}
