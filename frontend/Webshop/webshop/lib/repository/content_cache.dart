import 'package:hive/hive.dart';

import '../models/user.dart';
import 'cache.dart';

class ContentCache {
  static const _profileKey = 'profile';

  Future<Box> _open() => Cache.open('content');

  Future<void> saveProfile(User? profile) async {
    final box = await _open();
    await box.save(_profileKey, profile);
  }

  Future<User?> getProfile([bool ignoreValidity = false]) async {
    final box = await _open();
    final cached = box.read(_profileKey, ignoreValidity);
    return User.fromJson(cached);
  }

  Future<void> deleteProfile() async {
    final box = await _open();
    await box.remove(_profileKey);
  }

  Future<bool> hasProfile() async {
    final box = await _open();
    return box.containsKey(_profileKey);
  }
}
