import 'package:webshop/core/content.dart';
import 'package:webshop/repository/app_content.dart';

import '../../../core/ui_handler.dart';
import '../../../models/caff.dart';
import '../../../service/content_service.dart';

class ShopModel {
  final AppContent _content;
  final ContentService _contentService;
  final UiHandler uiHandler;

  ShopModel(this._content, this._contentService, this.uiHandler);

  Content<List<Caff>> get caffs => _content.ownedCaffs;
  //Content<User> get user => _content.user;

  Future<void> onRefresh() async {
    try {
      await _contentService.loadShopCaffs();
    } catch (e) {
      uiHandler.setError(e, retryCallback: onRefresh);
    }
  }
}
