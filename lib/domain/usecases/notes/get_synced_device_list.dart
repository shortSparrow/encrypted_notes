import 'package:cryptography/cryptography.dart';
import 'package:encrypted_notes/domain/models/notes/notes.dart';

final publicBytes_1 = [
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24,
  25,
  26,
  27,
  28,
  29,
  30,
  31,
  32
];
final publicBytes_2 = [
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24,
  25,
  26,
  27,
  28,
  29,
  30,
  31,
  33
];
final publicBytes_3 = [
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24,
  25,
  26,
  27,
  28,
  29,
  30,
  31,
  34
];

final devicePublicKey_1 =
    SimplePublicKey(publicBytes_1, type: KeyPairType.x25519);
final devicePublicKey_2 =
    SimplePublicKey(publicBytes_2, type: KeyPairType.x25519);
final devicePublicKey_3 =
    SimplePublicKey(publicBytes_3, type: KeyPairType.x25519);

// TODO implement real
class GetSyncedDeviceListUseCase {
  Future<List<SyncedDevice>> getSyncedDeviceList() async {
    return const [
      SyncedDevice(
        deviceId: "device_1",
        isSynced: false,
      ),
      SyncedDevice(
        deviceId: "device_2",
        isSynced: false,
      ),
      SyncedDevice(
        deviceId: "device_3",
        isSynced: false,
      ),
    ];
  }
}

List<SyncedDevice> getTestSyncedDeviceList() {
  return const [
    SyncedDevice(
      deviceId: "device_1",
      isSynced: false,
    ),
    SyncedDevice(
      deviceId: "device_2",
      isSynced: false,
    ),
    SyncedDevice(
      deviceId: "device_3",
      isSynced: false,
    ),
  ];
}
