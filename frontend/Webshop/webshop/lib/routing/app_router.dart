import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/caff.dart';
import '../pages/home/home_page.dart';
import '../pages/info/caff_info_page.dart';
import '../pages/login/login_page.dart';
import '../pages/signup/signup_page.dart';
import '../pages/splash/splash_page.dart';
import '../repository/app_content.dart';
import 'animated_page_builder.dart';
import 'app_route.dart';

class AppRouter {
  final GoRouter _router;

  get delegate => _router.routerDelegate;
  get informationParser => _router.routeInformationParser;
  get informationProvider => _router.routeInformationProvider;

  GlobalKey<NavigatorState> get navigatorState =>
      _router.routerDelegate.navigatorKey;

  AppRouter(AppContent content)
      : _router = GoRouter(
          urlPathStrategy: UrlPathStrategy.path,
          debugLogDiagnostics: kDebugMode,
          initialLocation: '/splash',
          routes: [
            GoRoute(
              path: '/splash',
              builder: (context, state) => const SplashPage(),
            ),
            GoRoute(
                path: '/login',
                name: RouteName.login,
                builder: (context, state) => LoginPage(),
                routes: [
                  GoRoute(
                    path: 'signup',
                    name: RouteName.signUp,
                    builder: (context, state) => SignUpPage(),
                  ),
                ]),
            GoRoute(
                path: '/home',
                name: RouteName.home,
                builder: (context, state) => const HomePage(),
                routes: [
                  GoRoute(
                    path: 'caff_info',
                    name: RouteName.caffInfo,
                    pageBuilder: (context, state) => AnimatedPageBuilder.left(
                      key: state.pageKey,
                      child: CaffInfoPage(model: state.extra as Caff),
                    ),
                  ),
                ]),
          ],
        );

  void push(AppRoute route) {
    _router.pushNamed(
      route.name,
      params: route.pathParams,
      queryParams: route.queryParams,
      extra: route.extra,
    );
  }

  void set(AppRoute route) {
    _router.goNamed(
      route.name,
      params: route.pathParams,
      queryParams: route.queryParams,
      extra: route.extra,
    );
  }

  void replace(AppRoute route) {
    _router.replaceNamed(
      route.name,
      params: route.pathParams,
      queryParams: route.queryParams,
      extra: route.extra,
    );
  }

  void pop() {
    try {
      _router.pop();
    } catch (e) {}
  }
}
