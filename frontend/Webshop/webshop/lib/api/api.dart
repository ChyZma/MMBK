import 'dart:io';

import 'package:api/api.dart';
import 'package:http/io_client.dart';

import '../app/config.dart';

ApiClient createApiClient(Config config) {
  return ApiClient(
    basePath: config.apiEndpoint,
    authentication: HttpBearerAuth(),
  );
}

class WebshopApi {
  final ApiClient apiClient;

  WebshopApi(this.apiClient, Config config) {
    HttpClient httpClient = HttpClient();
    httpClient.connectionTimeout = config.requestTimeout;
    apiClient.client = IOClient(httpClient);
    apiClient.addDefaultHeader("X-Api-Version", "${config.apiVersion}");
  }

  void setApiAuthentication(String token) {
    final auth = _getApiAuthentication()!;
    auth.accessToken = token;
  }

  void clearApiAuthentication() {
    final auth = _getApiAuthentication()!;
    auth.accessToken = '';
  }

  HttpBearerAuth? _getApiAuthentication() {
    return apiClient.authentication as HttpBearerAuth?;
  }
}
