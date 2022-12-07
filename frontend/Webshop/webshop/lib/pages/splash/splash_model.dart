import '../../app/ioc.dart';
import '../../core/content.dart';
import '../../core/error_handler.dart';
import '../../routing/app_route.dart';
import '../../service/content_service.dart';

class SplashModel {
  final ContentService _contentService;
  final ErrorHandler _errorHandler;

  SplashModel(
    this._contentService,
    this._errorHandler,
  );

  final retrying = Content<bool>(false);

  bool _showLogin = false;

  Future<void> init() async {
    await _waitAnimation();
    _showLogin = true;
    _loadAppContent();
  }

  Future<void> _loadAppContent() async {
    try {
      retrying.value = false;
      await _contentService.loadProfile();
      _showLogin = !_contentService.loggedIn();
      if (!_showLogin) {
        await _contentService.loadAllCaffs();
      }
      _finish();
    } catch (e) {
      retrying.value = true;
      _errorHandler.setError(e, retryCallback: _loadAppContent);
    }
  }

  Future<void> _finish() async {
    _dispatchRoute();
  }

  void _dispatchRoute() {
    if (_showLogin) {
      IoC.router.set(AppRoute.login());
    } else {
      IoC.router.set(AppRoute.home());
    }
  }

  Future<void> _waitAnimation() async {
    await Future.delayed(const Duration(milliseconds: 2500));
  }
}
