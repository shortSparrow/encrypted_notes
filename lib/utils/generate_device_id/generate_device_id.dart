import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

// TODO probable when start generate key pairs add hasing here (return not sting with ingo, but hash instead)
// TODO add tests
class GenerateDeviceId {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<String> generateUniqueDeviceId() async {
    String deviceId = await _loadDeviceId();
    final uniqueDeviceId = deviceId + DateTime.now().toString();
    return uniqueDeviceId;
  }

  Future<String> _loadDeviceId() async {
    if (kIsWeb) {
      final WebBrowserInfo webBrowserInfo = await _deviceInfo.webBrowserInfo;
      return webBrowserInfo.userAgent ??
          "${webBrowserInfo.appCodeName} ${webBrowserInfo.platform}";
    }

    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;

      return androidInfo.id;
      // TODO check with different build version (not SE1A.220630.001)
    }

    if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;

      return iosInfo.identifierForVendor ??
          '${iosInfo.model} ${iosInfo.name} ${iosInfo.systemName} ${iosInfo.systemVersion}';
    }

    if (Platform.isMacOS) {
      final MacOsDeviceInfo macOsInfo = await _deviceInfo.macOsInfo;
      return macOsInfo.systemGUID ??
          '${macOsInfo.model} ${macOsInfo.computerName}';
    }

    if (Platform.isLinux) {
      final LinuxDeviceInfo linuxInfo = await _deviceInfo.linuxInfo;
      return "${linuxInfo.id} ${linuxInfo.machineId} ${linuxInfo.name}";
    }

    if (Platform.isWindows) {
      final WindowsDeviceInfo windowsInfo = await _deviceInfo.windowsInfo;
      return windowsInfo.deviceId;
    }

    return 'unkown';
  }
}
