import 'package:encrypted_notes/data/database/dao/remote_device_dao.dart';
import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/data/mapper/remote_device_mapper.dart';
import 'package:encrypted_notes/domain/models/remote_device/remote_device.dart';
import 'package:encrypted_notes/domain/repositories/synced_client_repository_local.dart';

class RemoteDeviceRepositoryLocalImpl extends RemoteDeviceRepositoryLocal {
  final RemoteDevicesDao remoteDevicesDao;
  final RemoteDeviceMapper remoteDeviceMapper;

  RemoteDeviceRepositoryLocalImpl({
    required this.remoteDeviceMapper,
    required this.remoteDevicesDao,
  });

  @override
  Future addRemoteDevice(RemoteDevicesCompanion remoteDevice) {
    return remoteDevicesDao.addRemoteDevice(remoteDevice);
  }

  @override
  Stream<List<RemoteDevice>> getAllRemoteDevices() {
    return remoteDevicesDao.getRemoteDevices().watch().map((event) => event
        .map(
            (remoteDevice) => remoteDeviceMapper.dbToRemoteDevice(remoteDevice))
        .toList());
  }

  @override
  Future<List<RemoteDevice>> getListRemoteDeviceById(List<String> devicesId) async {
    final list = await remoteDevicesDao.getListRemoteDeviceById(devicesId);
    return list
        .map(
            (remoteDevice) => remoteDeviceMapper.dbToRemoteDevice(remoteDevice))
        .toList();
  }

  @override
  Future<RemoteDevice?> getRemoteDeviceById(String id) async {
    final remoteDevice = await remoteDevicesDao.getRemoteDeviceById(id);
    if (remoteDevice == null) return null;

    return remoteDeviceMapper.dbToRemoteDevice(remoteDevice);
  }

  @override
  Future<bool> updateRemoteDevice(RemoteDevicesCompanion remoteDevice) {
    return remoteDevicesDao.updateRemoteDevice(remoteDevice);
  }
}
