import 'package:webshop/service/user_service.dart';

import '../app/logging.dart';
import '../repository/app_content.dart';
import 'caff_service.dart';

class ContentService {
  final AppContent _content;
  final UserService _userService;
  final CaffService _caffService;

  ContentService(this._content, this._userService, this._caffService);

  Future<void> loadProfile() async {
    _content.user.value = null;

    try {
      await _userService.authenticate();
    } catch (e) {
      logError(e);
    }
  }

  Future<void> loadOwnedCaffs() async {
    _content.ownedCaffs.value = await _caffService.getAllCaffs();
    if (_content.ownedCaffs.value != null) {
      for (var item in _content.ownedCaffs.value!) {
        item.gif = await _caffService.getPreview(item.id, item.name);
      }
    }
  }

  //TODO
  Future<void> loadShopCaffs() async {
    _content.shopCaffs.value = await _caffService.getAllCaffs();
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
