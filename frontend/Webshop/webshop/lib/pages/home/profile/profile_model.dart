import 'package:webshop/service/user_service.dart';

import '../../../core/content.dart';
import '../../../models/user.dart';
import '../../../repository/app_content.dart';
import '../../../service/caff_service.dart';

class ProfileModel {
  final AppContent _content;
  final UserService _userService;
  final CaffService _caffService;

  ProfileModel(this._content, this._userService, this._caffService);

  Content<User> get user => _content.user;

  String? path;

  Future<void> logOut() async {
    try {
      await _userService.signOut();
    } catch (e) {}
  }

  Future<void> uploadCaff() async {
    if (path != null) {
      await _caffService.uploadCaff(path!);
    }
    path = null;
  }
}
