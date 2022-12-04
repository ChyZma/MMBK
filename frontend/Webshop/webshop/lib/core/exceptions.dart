class AppException implements Exception {
  final String? message;
  final dynamic source;

  AppException(this.source, {this.message});

  @override
  String toString() {
    if (message == null) return "Exception";
    return "Exception: $message";
  }
}

class AuthException extends AppException {
  AuthException(super.source);
}

class AuthAbortedException implements Exception {}

class ExternalStorageAccessException implements Exception {}

class NetworkException extends AppException {
  NetworkException(super.source);
}

class InternalServerException extends AppException {
  InternalServerException(super.source);
}
