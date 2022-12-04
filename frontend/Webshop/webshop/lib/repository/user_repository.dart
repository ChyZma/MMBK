import 'package:api/api.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:webshop/repository/secure_store.dart';

import '../app/logging.dart';
import '../models/user.dart';
import '../service/auth_service.dart';
import 'content_cache.dart';

class UserRepository {
  final UserApi _api;
  final AuthService _authService;
  final ContentCache _contentCache;
  final SecureStore _secureStore;

  UserRepository(
      this._authService, this._api, this._contentCache, this._secureStore);

  Future<User?> getOrLoadUser() async {
    User? cachedProfile = await _contentCache.getProfile();
    String? cachedToken = await _secureStore.getToken();
    if (cachedProfile == null || cachedToken == null) {
      return null;
    } else {
      _authService.signIn(cachedToken);
      return User.from(cachedProfile);
    }
  }

  Future signOut() async {
    await _authService.signOut();
    await _contentCache.deleteProfile();
    await _secureStore.deleteToken();
  }

  Future<void> deleteProfile(String id) async {
    await _api.apiUserIdDelete(id);
  }

  Future<void> registerProfile(RegisterRequest profile) async {
    await _api.apiUserRegisterPost(registerRequest: profile);
  }

  Future<User?> signIn(LoginRequest userReq) async {
    var token = await _api.apiUserLoginPost(loginRequest: userReq);
    if (token != null) {
      logMessage("Auth token: $token");
      _authService.signIn(token.token);
      var role = _parseToken(token.token);
      var user = User(name: userReq.userName, role: role);
      _contentCache.saveProfile(user);
      _secureStore.saveToken(token.token);
      return user;
    }
    return null;
  }

  Role _parseToken(String token) {
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    switch (
        payload["http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"]) {
      case 'user':
        return Role.user;
      case 'admin':
        return Role.admin;
    }
    return Role.user;
  }

  Future<List<User>?> loadAllUser() async {
    var userResponseList = await _api.apiUserGet();
    return userResponseList!.map((e) => User.fromUserResponse(e)).toList();
  }
}
