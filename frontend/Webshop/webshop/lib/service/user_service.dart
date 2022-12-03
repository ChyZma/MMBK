import 'package:api/api.dart';

import '../repository/app_content.dart';
import '../repository/user_repository.dart';

class UserService {
  final AppContent _content;
  final UserRepository _repo;

  UserService(
    this._content,
    this._repo,
  );

  Future<bool> signIn(LoginRequest user) async {
    try {
      _content.user.value = await _repo.signIn(user);
      return _content.user.value != null;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> authenticate() async {
    try {
      _content.user.value = await _repo.getOrLoadUser();
    } catch (e) {
      _content.user.value = null;
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _repo.signOut();
    _content.user.value = null;
  }

  Future deleteProfile(String id) async {
    try {
      await _repo.deleteProfile(id);
      _content.user.value = null;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> register(RegisterRequest profile) async {
    try {
      await _repo.registerProfile(profile);
    } catch (e) {
      rethrow;
    }
  }
}
