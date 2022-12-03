import 'dart:io';

bool isNetworkError(Exception? e) {
  return e is SocketException || e is TlsException || e is IOException;
}
