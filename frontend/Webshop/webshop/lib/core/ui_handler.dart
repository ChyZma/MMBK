import 'app_error.dart';
import 'content.dart';
import 'error_handler.dart';
import 'loading_handler.dart';

class UiHandler {
  final LoadingHandler loadingHandler;
  final ErrorHandler errorHandler;

  UiHandler(
    this.loadingHandler,
    this.errorHandler,
  );

  bool get isLoading => loadingHandler.isLoading;
  Content<String?> get load => loadingHandler.loading;
  String? get loadingKey => load.value;

  void setLoading([String loadingKey = 'loading']) {
    loadingHandler.setLoading(loadingKey);
    errorHandler.clear();
  }

  void clearError() {
    errorHandler.clear();
  }

  void setError(
    dynamic e, {
    ErrorCallback? primaryCallback,
    ErrorCallback? secondaryCallback,
    ErrorCallback? retryCallback,
  }) {
    loadingHandler.clearLoading();
    errorHandler.setError(
      e,
      primaryCallback: primaryCallback,
      secondaryCallback: secondaryCallback,
      retryCallback: retryCallback,
    );
  }

  void setFinished() {
    loadingHandler.clearLoading();
  }
}
