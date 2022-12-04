import 'dart:io';

import 'package:api/api.dart';
import 'package:http/http.dart' as http;

class CaffRepository {
  final CaffApi _api;

  CaffRepository(
    this._api,
  );

  Future<List<CaffResponse>?> getCaffs() async {
    return await _api.apiCaffGet();
  }

  Future<void> uploadCaff(String path) async {
    File file = File(path);
    var multi = http.MultipartFile.fromBytes('file', file.readAsBytesSync());
    var request = CaffUploadRequest(file: multi);
    await _api.apiCaffPost(caffUploadRequest: request);
  }

  Future<void> deleteCaff(int id) async {
    await _api.apiCaffIdDelete(id);
  }

  //todo: preview

  //todo: get by id
}
