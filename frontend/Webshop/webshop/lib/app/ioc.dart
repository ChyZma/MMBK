import 'package:api/api.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:webshop/api/api.dart';
import 'package:webshop/core/ui_handler.dart';
import 'package:webshop/pages/home/profile/profile_model.dart';
import 'package:webshop/repository/caff_repository.dart';
import 'package:webshop/repository/content_cache.dart';
import 'package:webshop/repository/secure_store.dart';
import 'package:webshop/service/auth_service.dart';

import '../core/error_handler.dart';
import '../core/loading_handler.dart';
import '../pages/home/owned_list/owned_list_model.dart';
import '../pages/home/shop_list/shop_model.dart';
import '../pages/login/login_model.dart';
import '../pages/signup/signup_model.dart';
import '../pages/splash/splash_model.dart';
import '../repository/app_content.dart';
import '../repository/cache.dart';
import '../repository/encrypted_store.dart';
import '../repository/user_repository.dart';
import '../routing/app_router.dart';
import '../service/caff_service.dart';
import '../service/content_service.dart';
import '../service/platform_service.dart';
import '../service/user_service.dart';
import 'config.dart';
import 'logging.dart';

class IoC {
  IoC._();

  static Future<void> init(Config config) async {
    const logger = kReleaseMode ? ReleaseLogger() : DebugLogger();
    GetIt.I.registerSingleton<Logger>(logger);

    final platformService = PlatformService();
    await Future.wait([
      Cache.init(),
      Store.init(),
      platformService.init(),
    ]);

    GetIt.I.registerSingleton(platformService);

    GetIt.I.registerSingleton(config);
    GetIt.I.registerSingleton(AppContent());
    GetIt.I.registerSingleton(AppRouter(get()));
    GetIt.I.registerSingleton(ContentCache());
    GetIt.I.registerSingleton(SecureStore());

    GetIt.I.registerFactory(() => LoadingHandler());
    GetIt.I.registerFactory(() => ErrorHandler());
    GetIt.I.registerFactory(() => UiHandler(get(), get()));

    final apiClient = createApiClient(get());
    GetIt.I.registerSingleton(WebshopApi(apiClient, get()));
    GetIt.I.registerSingleton(UserApi(apiClient));
    GetIt.I.registerSingleton(CaffApi(apiClient));
    GetIt.I.registerSingleton(CaffCommentApi(apiClient));

    GetIt.I.registerSingleton(AuthService(get()));
    GetIt.I.registerSingleton(UserRepository(get(), get(), get(), get()));
    GetIt.I.registerSingleton(CaffRepository(get(), get()));
    GetIt.I.registerSingleton(UserService(get(), get()));
    GetIt.I.registerSingleton(CaffService(get(), get()));
    GetIt.I.registerSingleton(ContentService(get(), get(), get()));

    GetIt.I.registerFactory(() => SplashModel(get(), get()));
    GetIt.I.registerFactory(() => ProfileModel(get(), get(), get(), get()));
    GetIt.I.registerFactory(() => ShopModel(get(), get(), get()));
    GetIt.I.registerFactory(() => OwnedModel(get(), get(), get()));
    GetIt.I.registerFactory(() => LoginModel(get(), get(), get(), get()));
    GetIt.I.registerFactory(() => SignUpModel(get(), get()));
  }

  static T get<T extends Object>() => GetIt.I.get<T>();

  static AppRouter get router => get<AppRouter>();
  static Config get config => get<Config>();
  static Logger get logger => get<Logger>();
}
