import 'package:api/api.dart';
import 'package:webshop/app/logging.dart';
import 'package:webshop/core/ui_handler.dart';
import 'package:webshop/repository/app_content.dart';

import '../../app/ioc.dart';
import '../../models/user.dart';
import '../../routing/app_route.dart';
import '../../service/content_service.dart';
import '../../service/user_service.dart';

class LoginModel {
  final AppContent _content;
  final UiHandler uiHandler;
  final UserService _userService;
  final ContentService _contentService;

  LoginModel(
      this.uiHandler, this._userService, this._content, this._contentService);

  final user = LoginRequest();

  Future<void> login() async {
    if (uiHandler.isLoading) return;

    uiHandler.setLoading();
    try {
      await _userService.signIn(user);
      await _handleResult();
    } catch (e) {
      uiHandler.setError(e, retryCallback: login);
    } finally {
      uiHandler.setFinished();
    }
  }

  Future<void> _handleResult() async {
    if (_content.user.value != null) {
      await _loadShopCaffs();
      if (_content.user.value!.role == Role.user) {
        await _loadOwnedCaffs();
      }
      if (_content.user.value!.role == Role.admin) {
        await _loadUserList();
      }
      IoC.router.set(AppRoute.home());
    }
  }

  Future<void> _loadShopCaffs() async {
    try {
      await _contentService.loadShopCaffs();
    } catch (e) {
      logError(e);
    }
  }

  Future<void> _loadOwnedCaffs() async {
    try {
      await _contentService.loadOwnedCaffs();
    } catch (e) {
      logError(e);
    }
  }

  Future<void> _loadUserList() async {
    try {
      await _contentService.loadUsers();
    } catch (e) {
      logError(e);
    }
  }
}
