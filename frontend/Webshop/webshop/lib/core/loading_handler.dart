import 'content.dart';

class LoadingHandler {
  final loading = Content<String?>();

  LoadingHandler();

  void setLoading([String key = 'loading']) {
    loading.value = key;
  }

  void clearLoading() {
    loading.value = null;
  }

  bool get isLoading => loading.value != null;
}
