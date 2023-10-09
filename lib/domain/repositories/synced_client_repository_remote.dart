import 'package:encrypted_notes/domain/models/remote_device/remote_device.dart';

abstract class RemoteDeviceRepositoryRemote {
  Future<RemoteDevice?> getRemoteDeviceById(String id);
  Future<List<RemoteDevice>> getAllRemoteDevices();
  Future registerRemoteDevices(RemoteDevice remoteDevice);
}