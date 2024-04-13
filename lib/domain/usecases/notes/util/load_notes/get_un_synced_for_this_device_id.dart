import 'package:encrypted_notes/domain/models/notes/notes.dart';
import 'package:collection/collection.dart';

getUnSyncedForSpecificDevice(String deviceId, List<EncryptedNote> notes) {
  return notes.where((element) {
    return element.syncedDevices.firstWhereOrNull(
            (syncDevice) => syncDevice.deviceId == deviceId) !=
        null;
  }).toList();
}
