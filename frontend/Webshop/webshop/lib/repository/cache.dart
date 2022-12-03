import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../service/platform_service.dart';

class Cache {
  Cache._();

  static Future<void> init() async {
    final appDir = PlatformService.isIos
        ? await getApplicationSupportDirectory()
        : await getApplicationDocumentsDirectory();
    final homeDir = path.join(appDir.path, "storage");
    Hive.init(homeDir);
  }

  static Future<Box<E>> open<E>(String name) => Hive.openBox<E>(name);
  static Future<void> drop(String name) => Hive.deleteBoxFromDisk(name);
}

extension HiveExtension on Box {
  static const _expiryDuration = Duration(hours: 1);

  Future save(String key, dynamic value) async {
    await put(key, jsonEncode(value));
    await put('$key-timestamp', DateTime.now().toIso8601String());
  }

  Future remove(String key) async {
    await delete(key);
    await delete('$key-timestamp');
  }

  dynamic read(String key, [bool ignoreValidity = false]) {
    if (ignoreValidity || _isCachedValueValid(key)) {
      final cached = get(key);
      return cached == null ? null : jsonDecode(cached);
    } else {
      return null;
    }
  }

  bool _isCachedValueValid(String key) {
    final saveTimestamp = get('$key-timestamp', defaultValue: '');
    try {
      final saveTime = DateTime.parse(saveTimestamp);
      final expirationTime = DateTime.now().subtract(_expiryDuration);
      return saveTime.isAfter(expirationTime);
    } catch (e) {
      return false;
    }
  }
}
