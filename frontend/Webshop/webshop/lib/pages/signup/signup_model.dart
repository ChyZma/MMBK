import 'package:api/api.dart';
import 'package:webshop/app/ioc.dart';
import 'package:webshop/core/ui_handler.dart';

import '../../service/user_service.dart';

class SignUpModel {
  final UiHandler uiHandler;
  final UserService _userService;

  SignUpModel(this.uiHandler, this._userService);

  final profile = RegisterRequest();

  Future<void> register() async {
    if (uiHandler.isLoading) return;

    uiHandler.setLoading();
    try {
      await _userService.register(profile);
    } catch (e) {
      uiHandler.setError(e, retryCallback: register);
    } finally {
      uiHandler.setFinished();
      IoC.router.pop();
    }
  }
}
