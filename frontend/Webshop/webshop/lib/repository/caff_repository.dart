import 'dart:io';
import 'dart:typed_data';

import 'package:api/api.dart';
import 'package:http/http.dart' as http;

import '../models/caff.dart';
import 'app_content.dart';

class CaffRepository {
  final CaffApi _api;
  final AppContent _content;

  CaffRepository(
    this._api,
    this._content,
  );

  Future<List<Caff>?> getCaffs() async {
    var result = await _api.apiCaffGet();
    return result!.map((e) => Caff.from(e)).toList();
  }

  Future<void> uploadCaff(String path) async {
    File file = File(path);
    var multipartfile = http.MultipartFile.fromBytes(
        filename: path.split('/').last, 'file', file.readAsBytesSync());
    await _api.apiCaffPost(multipartFile: multipartfile);
  }

  Future<Uint8List> getPreview(int id) async {
    return _api.apiCaffIdPreviewGet(id);
  }

  Future<void> deleteCaff(int id) async {
    await _api.apiCaffIdDelete(id);
  }

  //todo: get by id
  Future<void> getCaffById(int id) async {
    await _api.apiCaffIdGet(id);
  }
}
