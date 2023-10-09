import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/domain/models/remote_device/remote_device.dart';

abstract class RemoteDeviceRepositoryLocal {
  Future<RemoteDevice?> getRemoteDeviceById(String id);
  Future<List<RemoteDevice>> getListRemoteDeviceById(List<String> devicesId);
  Stream<List<RemoteDevice>> getAllRemoteDevices();
  Future addRemoteDevice(RemoteDevicesCompanion remoteDevice);
  Future<bool> updateRemoteDevice(RemoteDevicesCompanion remoteDevice);
}