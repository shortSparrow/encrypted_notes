import 'package:encrypted_notes/domain/models/remote_device/remote_device.dart';

abstract class ServerEncryptionApi  {
  Future sendThisSyncedDevice();
  Future<List<RemoteDevice>> getAllMyDevices();
  Future<List<RemoteDevice>> getAllSharedToMeDevices();
}