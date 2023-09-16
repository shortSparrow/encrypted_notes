import 'package:encrypted_notes/domain/models/notes/notes.dart';

abstract class ServerEncryptionApi  {
  Future sendThisSyncedDevice();
  Future<List<SyncedDevice>> getAllMyDevices();
  Future<List<SyncedDevice>> getAllSharedToMeDevices();
}