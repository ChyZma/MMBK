import 'package:webshop/api/api.dart';

class AuthService {
  final WebshopApi _api;

  AuthService(this._api);

  Future<void> signIn(String token) async {
    _api.setApiAuthentication(token);
  }

  Future<void> signOut() async {
    _api.clearApiAuthentication();
  }

  Future<void> deleteUser() async {
    _api.clearApiAuthentication();
  }
}
