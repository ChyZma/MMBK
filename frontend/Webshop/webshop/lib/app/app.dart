import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webshop/app/theme.dart';

import 'config.dart';
import 'ioc.dart';

Future<void> startApp(Config config) async {
  WidgetsFlutterBinding.ensureInitialized();
  await IoC.init(config);
  runApp(const WebshopApp());
}

class WebshopApp extends StatelessWidget {
  const WebshopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'caffShop',
      routerDelegate: IoC.router.delegate,
      routeInformationParser: IoC.router.informationParser,
      routeInformationProvider: IoC.router.informationProvider,
      theme: AppTheme.materialTheme,
    );
  }
}
