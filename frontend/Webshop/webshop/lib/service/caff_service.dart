import 'package:webshop/repository/app_content.dart';
import 'package:webshop/repository/caff_repository.dart';

class CaffService {
  final AppContent _content;
  final CaffRepository _repo;

  CaffService(this._content, this._repo);

  Future<void> uploadCaff(String path) async {
    try {
      await _repo.uploadCaff(path);
    } catch (e) {
      rethrow;
    }
  }
}
