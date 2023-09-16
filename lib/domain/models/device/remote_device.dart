import 'package:cryptography/cryptography.dart';

enum DeviceType { phone, browser, laptop, unknown }

enum BrowserBrand { chrome, firefox, opera, edge, safari, unknown }

enum MobileBrand { android, ios, unknown }

enum LaptopBrand { lg, apple, unknown }

abstract class RemoteDevice {
  final String deviceId;
  final SimplePublicKey devicePublicKey;
  final String deviceName;
  final String? systemVersion;

  RemoteDevice({
    required this.deviceId,
    required this.devicePublicKey,
    required this.deviceName,
    required this.systemVersion,
  });
}

class PhoneDevice extends RemoteDevice {
  final MobileBrand brand;

  PhoneDevice({
    required super.deviceId,
    required super.devicePublicKey,
    required super.deviceName,
    required super.systemVersion,
    required this.brand,
  });
}

class Browser extends RemoteDevice {
  final BrowserBrand brand;

  Browser({
    required super.deviceId,
    required super.devicePublicKey,
    required super.deviceName,
    required super.systemVersion,
    required this.brand,
  });
}

class Laptop extends RemoteDevice {
  final LaptopBrand brand;

  Laptop({
    required super.deviceId,
    required super.devicePublicKey,
    required super.deviceName,
    required super.systemVersion,
    required this.brand,
  });
}
