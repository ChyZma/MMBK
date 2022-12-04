import 'package:hive/hive.dart';

import 'cache.dart';
import 'encrypted_store.dart';

class SecureStore {
  static const _tokenKey = 'token';

  Future<Box> _open() => Store.openEncrypted('content');

  Future<void> saveToken(String? token) async {
    final box = await _open();
    await box.save(_tokenKey, token);
    box.close();
  }

  Future<String?> getToken() async {
    final box = await _open();
    final cached = box.read(_tokenKey);
    box.close();
    return cached;
  }

  Future<void> deleteToken() async {
    final box = await _open();
    await box.remove(_tokenKey);
  }

  Future<bool> hasToken() async {
    final box = await _open();
    return box.containsKey(_tokenKey);
  }
}
