import 'package:drift/drift.dart';
import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/domain/models/remote_device/remote_device.dart';
import 'package:encrypted_notes/extensions/encryption_key_extension.dart';

class RemoteDeviceMapper {
  RemoteDevicesCompanion remoteDeviceToDb(RemoteDevice remoteDevice) {
    return RemoteDevicesCompanion(
      id: Value(remoteDevice.id),
      deviceName: Value(remoteDevice.deviceName),
      systemVersion: Value(remoteDevice.systemVersion),
      devicePublicKey: Value(remoteDevice.devicePublicKey.toJsonString()),
    );
  }

  RemoteDevice dbToRemoteDevice(RemoteDeviceDb remoteDeviceDb) {
    return RemoteDevice(
      id: remoteDeviceDb.id,
      deviceName: remoteDeviceDb.deviceName,
      systemVersion: remoteDeviceDb.systemVersion,
      devicePublicKey: SimplePublicKeyConvertorExtension.fromJsonString(
          remoteDeviceDb.devicePublicKey),
    );
  }
}
