import 'package:cryptography/cryptography.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'remote_device.freezed.dart';

enum DeviceType { phone, browser, laptop, unknown }

enum BrowserBrand { chrome, firefox, opera, edge, safari, unknown }

enum MobileBrand { android, ios, unknown }

enum LaptopBrand { lg, apple, unknown }

@freezed
class RemoteDevice with _$RemoteDevice {
  const factory RemoteDevice({
    required String
        id, // unique id for client on device (not the same as loadDeviceId). Must be generated by server
    required SimplePublicKey devicePublicKey,
    required String deviceName,
    required String? systemVersion,
    // required DeviceType type,
    // required String brand,
  }) = _RemoteDevice;

  // factory RemoteDevice.phoneDevice({
  //       required String id,
  //   required SimplePublicKey devicePublicKey,
  //   required String deviceName,
  //   required String? systemVersion,
  //   required DeviceType type,
  //   required MobileBrand brand,
  // })
}
