import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';

class PlatformService {
  late final String storeUrl;
  late final String version;
  late final bool appleSignInAvailable;
  late final bool physicalDevice;

  static bool get isIos => Platform.isIOS;
  static bool get isAndroid => Platform.isAndroid;

  Future<void> init() async {
    if (isIos) {
      await _initIos();
    } else {
      await _initAndroid();
    }

    final info = await PackageInfo.fromPlatform();
    version = info.version;
  }

  Future<void> _initAndroid() async {
    final deviceInfo = DeviceInfoPlugin();
    final info = await deviceInfo.androidInfo;
    physicalDevice = info.isPhysicalDevice;
    appleSignInAvailable = false;
    storeUrl = "";
  }

  Future<void> _initIos() async {
    final deviceInfo = DeviceInfoPlugin();
    final iosInfo = await deviceInfo.iosInfo;
    physicalDevice = iosInfo.isPhysicalDevice;
    appleSignInAvailable = await _checkIfAppleSignInAvailable(iosInfo);
    storeUrl = "";
  }

  Future<bool> _checkIfAppleSignInAvailable(IosDeviceInfo iosInfo) async {
    try {
      final chunks = iosInfo.systemVersion.split('.');
      final majorSystemVersion = int.parse(chunks.first);
      return majorSystemVersion >= 13;
    } catch (e) {
      return false;
    }
  }
}
