import 'package:webshop/core/content.dart';
import 'package:webshop/repository/app_content.dart';

import '../../../models/caff.dart';
import '../../../models/user.dart';

class ShopModel {
  final AppContent _content;

  ShopModel(this._content);

  Content<List<Caff>> get caffs => _content.shopCaffs;
  Content<User> get user => _content.user;
}
