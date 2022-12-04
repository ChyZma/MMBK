import 'dart:io';

import 'app/app.dart';
import 'app/config.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  const config = Config(
    apiEndpoint: 'https://10.0.2.2:44331',
  );
  startApp(config);
}
