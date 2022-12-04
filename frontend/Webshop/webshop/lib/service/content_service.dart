import 'package:webshop/service/user_service.dart';

import '../app/logging.dart';
import '../models/caff.dart';
import '../repository/app_content.dart';

class ContentService {
  final AppContent _content;
  final UserService _userService;

  ContentService(this._content, this._userService);

  Future<void> loadProfile() async {
    _content.user.value = null;

    try {
      await _userService.authenticate();
    } catch (e) {
      logError(e);
    }
  }

  //TODO
  Future<void> loadOwnedCaffs() async {
    _content.ownedCaffs.value = [
      Caff(0, '1. caff', []),
      Caff(1, '2. caff', []),
      Caff(2, '3. caff', []),
    ];
  }

  //TODO
  Future<void> loadShopCaffs() async {
    _content.ownedCaffs.value = [
      Caff(3, '4. caff', []),
      Caff(4, '5. caff', []),
      Caff(5, '6. caff', []),
    ];
  }

  Future<void> loadAllCaffs() async {
    await loadOwnedCaffs();
    await loadShopCaffs();
  }

  Future<void> loadUsers() async {
    _userService.loadUsers();
  }

  bool loggedIn() {
    return _content.user.value != null;
  }
}
