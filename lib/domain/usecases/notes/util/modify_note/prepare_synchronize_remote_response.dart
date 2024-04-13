import 'package:encrypted_notes/domain/models/notes/modify_notes.dart';
import 'package:encrypted_notes/domain/models/notes/notes.dart';

List<SyncedDevice> prepareSynchronizeRemoteResponse(
  List<NoteResponse> notesForAllDevices,
  EncryptedNote? note,
) {
  final syncingDeviceStatusList = notesForAllDevices
      .map((item) => SyncedDevice(
            deviceId: item.deviceId,
            isSynced: item.isSuccess,
          ))
      .toList();

  final newSyncedDevices = note?.syncedDevices ?? List.empty();

  final updated = newSyncedDevices.map((device) {
    final indexExistingDevice = syncingDeviceStatusList
        .indexWhere((element) => element.deviceId == device.deviceId);

    if (indexExistingDevice != -1) {
      final updatedDevice =
          syncingDeviceStatusList.removeAt(indexExistingDevice);
      return updatedDevice;
    } else {
      return device;
    }
  }).toList();

  updated.addAll(syncingDeviceStatusList);
  return updated;
}
