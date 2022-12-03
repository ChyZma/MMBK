class RouteName {
  RouteName._();
  static const splash = 'splash';
  static const login = 'login';
  static const signUp = 'signUp';
  static const home = 'home';
  static const caffInfo = 'caff_info';
  static const profile = 'profile';
  static const settings = 'settings';
  static const editUsers = 'edit_users';
  static const editCaffs = 'edit_caffs';
}

class AppRoute {
  final String name;
  final Map<String, String> pathParams, queryParams;
  final Object? extra;

  /// NOTE extra must be serializable!
  AppRoute._(
    this.name, {
    this.extra = const {},
    this.pathParams = const {},
    this.queryParams = const {},
  });

  factory AppRoute.splash() => AppRoute._(RouteName.splash);
  factory AppRoute.login() => AppRoute._(RouteName.login);
  factory AppRoute.signUp() => AppRoute._(RouteName.signUp);
  factory AppRoute.home() => AppRoute._(RouteName.home);
  factory AppRoute.caffInfo(boat) =>
      AppRoute._(RouteName.caffInfo, extra: boat);
  factory AppRoute.profile() => AppRoute._(RouteName.profile);
  factory AppRoute.settings() => AppRoute._(RouteName.settings);
  factory AppRoute.editUsers() => AppRoute._(RouteName.editUsers);
  factory AppRoute.editCaffs() => AppRoute._(RouteName.editCaffs);
}
