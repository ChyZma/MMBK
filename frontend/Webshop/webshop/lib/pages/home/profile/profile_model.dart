import 'package:webshop/service/user_service.dart';

import '../../../core/content.dart';
import '../../../models/user.dart';
import '../../../repository/app_content.dart';

class ProfileModel {
  final AppContent _content;
  final UserService _userService;

  ProfileModel(this._content, this._userService);

  Content<User> get user => _content.user;

  Future<void> logOut() async {
    try {
      await _userService.signOut();
    } catch (e) {}
  }
}
