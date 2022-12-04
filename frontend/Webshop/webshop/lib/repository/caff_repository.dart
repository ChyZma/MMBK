import 'package:api/api.dart';
import 'package:dio/dio.dart';

import '../app/logging.dart';

class CaffRepository {
  final CaffApi _api;

  CaffRepository(
    this._api,
  );

  Future<List<CaffResponse>?> getCaffs() async {
    return await _api.apiCaffGet();
  }

  Future<void> uploadCaff(String path) async {
    // File file = File(path);
    // var multi = http.MultipartFile.fromBytes('file', file.readAsBytesSync());
    // var request = CaffUploadRequest(file: multi);
    // await _api.apiCaffPost(multipartFile: multi);
    var headerParams = <String, String>{};
    headerParams['Authorization'] =
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiYmVuY2UiLCJqdGkiOiJjYzE1MjhjNy1hMWU5LTRkZTMtODI4OS1iYzU4NjFmMGI0ZmYiLCJleHAiOjE2NzAxODI4MjgsImlzcyI6ImNhZmZiYWNrZW5kIn0.epcJYT0ems8Fq0IP9i4LgaM01aICDZHR4gVBU8UpAlQ';
    var uri = Uri.https('10.0.2.2:44331', r'/api/Caff');
    // var request = http.MultipartRequest('POST', uri)
    //   ..headers.addAll(headerParams)
    //   ..files.add(
    //       http.MultipartFile.fromBytes('file', File(path).readAsBytesSync()))
    //   ..fields['test'] = 'teststring';

    // var response = await request.send();
    // var responseData = await response.stream.toBytes();
    // logMessage("Response message:\n\n");
    // logMessage(String.fromCharCodes(responseData));
    // if (response.statusCode >= HttpStatus.badRequest) {
    //   throw ApiException(response.statusCode, response.toString());
    // }

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(path),
    });
    Dio dio = Dio();
    dio.options.headers['Authorization'] =
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiYmVuY2UiLCJqdGkiOiI0MjIwNzM1YS1kN2Y0LTQyNTItODdkMC1jNWNiZDIxMWJlZjMiLCJleHAiOjE2NzAxODUxNjgsImlzcyI6ImNhZmZiYWNrZW5kIn0.ibnSX0bT0VbEO3Jj1Y9uv8Ist4SYBVQT1k-yfYcLMPc';
    try {
      var response = await dio.post('https://10.0.2.2:44331/api/Caff',
          data: formData, options: Options(validateStatus: (status) {
        return status! <= 500;
      }));
    } catch (e) {
      logMessage("Response message:\n\n");
      logMessage(e);
    }
  }

  Future<void> deleteCaff(int id) async {
    await _api.apiCaffIdDelete(id);
  }

  //todo: preview
  Future<void> caffPreview(int id) async {
    await _api.apiCaffIdPreviewGet(id);
  }

  //todo: get by id
  Future<void> getCaffById(int id) async {
    await _api.apiCaffIdGet(id);
  }
}
