class Config {
  final int apiVersion;
  final String apiEndpoint;
  final Duration requestTimeout;

  const Config({
    required this.apiEndpoint,
    this.apiVersion = 1,
    this.requestTimeout = const Duration(seconds: 10),
  });
}
