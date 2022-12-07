import 'dart:typed_data';

import 'package:webshop/app/logging.dart';
import 'package:webshop/repository/app_content.dart';
import 'package:webshop/repository/caff_repository.dart';

import '../models/caff.dart';

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

  Future<List<Caff>?> getAllCaffs() async {
    try {
      return await _repo.getCaffs();
    } catch (e) {
      rethrow;
    }
  }

  Future<Uint8List> getPreview(int id, String path) async {
    try {
      return await _repo.getPreview(id);
      // return File.fromRawPath(data);
    } catch (e) {
      logMessage('File convert Error');
      rethrow;
    }
  }
}
