import 'package:webshop/core/ui_handler.dart';
import 'package:webshop/service/user_service.dart';

import '../../../core/content.dart';
import '../../../models/user.dart';
import '../../../repository/app_content.dart';
import '../../../service/caff_service.dart';

class ProfileModel {
  final AppContent _content;
  final UiHandler uiHandler;
  final UserService _userService;
  final CaffService _caffService;

  ProfileModel(
      this._content, this._userService, this._caffService, this.uiHandler);

  Content<User> get user => _content.user;

  String? path;

  String get fileName => path!.split('/').last;

  Future<void> logOut() async {
    if (uiHandler.isLoading) return;

    uiHandler.setLoading();
    try {
      await _userService.signOut();
    } catch (e) {
      uiHandler.setError(e, retryCallback: logOut);
    }
    uiHandler.setFinished();
  }

  Future<void> uploadCaff() async {
    if (uiHandler.isLoading) return;

    uiHandler.setLoading();
    try {
      if (path != null) {
        await _caffService.uploadCaff(path!);
      }
      path = null;
    } catch (e) {
      uiHandler.setError(e, retryCallback: uploadCaff);
    } finally {
      uiHandler.setFinished();
    }
  }
}
