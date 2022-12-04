import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class Store {
  static const _encryptionKey = "encryption_key";

  static Future<void> init() async {
    final appDir = Platform.isIOS
        ? await getApplicationSupportDirectory()
        : await getApplicationDocumentsDirectory();
    final homeDir = path.join(appDir.path, "storage");
    Hive.init(homeDir);

    const secureStorage = FlutterSecureStorage();
    final encryptionKey = await secureStorage.read(key: _encryptionKey);
    if (encryptionKey == null) {
      final encodedKey = base64Url.encode(Hive.generateSecureKey());
      await secureStorage.write(key: _encryptionKey, value: encodedKey);
    }
  }

  // ignore: unused_element
  static Future<Box<E>> open<E>(String name) => Hive.openBox<E>(name);
  static Future<void> drop(String name) => Hive.deleteBoxFromDisk(name);

  static Future<Box<E>> openEncrypted<E>(String name) async {
    const secureStorage = FlutterSecureStorage();
    final encryptedKey = await secureStorage.read(key: _encryptionKey);
    final key = base64Url.decode(encryptedKey!);
    return await Hive.openBox<E>(
      name,
      encryptionCipher: HiveAesCipher(key),
    );
  }
}
