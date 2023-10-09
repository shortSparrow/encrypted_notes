import 'package:encrypted_notes/domain/models/remote_device/remote_device.dart';
import 'package:encrypted_notes/domain/repositories/synced_client_repository_remote.dart';

class RemoteDeviceRepositoryImpl extends RemoteDeviceRepositoryRemote {
  @override
  Future<List<RemoteDevice>> getAllRemoteDevices() {
    // TODO: implement getAllRemoteDevices
    throw UnimplementedError();
  }

  @override
  Future<RemoteDevice?> getRemoteDeviceById(String id) {
    // TODO: implement getRemoteDeviceById
    throw UnimplementedError();
  }

  @override
  Future registerRemoteDevices(RemoteDevice remoteDevice) {
    // TODO: implement registerRemoteDevices
    throw UnimplementedError();
  }
}
