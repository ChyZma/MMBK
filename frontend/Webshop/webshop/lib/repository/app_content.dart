import '../core/content.dart';
import '../models/caff.dart';
import '../models/user.dart';

class AppContent {
  AppContent();

  final user = Content<User>();
  final ownedCaffs = Content<List<Caff>>();
  final shopCaffs = Content<List<Caff>>();
}
