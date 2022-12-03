typedef ErrorCallback = void Function();

class AppError {
  final String title, message, primaryText;
  final String? secondaryText;
  late final ErrorCallback? primaryCallback, secondaryCallback;
  late final dynamic source;

  AppError({
    required this.title,
    required this.message,
    required this.primaryText,
    this.secondaryText,
  });

  factory AppError.network({
    String title = 'Ajjaj',
    String message = 'Ellenőrizd a hálózati kapcsolatot',
    String primaryText = 'Újra',
    String? secondaryText = 'Vissza',
  }) {
    return AppError(
      title: title,
      message: message,
      primaryText: primaryText,
      secondaryText: secondaryText,
    );
  }

  factory AppError.server({
    String title = 'Szerver error',
    String message = 'Valami nem jó, próbáld újra később',
    String primaryText = 'Újra',
    String? secondaryText = 'Vissza',
  }) {
    return AppError(
      title: title,
      message: message,
      primaryText: primaryText,
      secondaryText: secondaryText,
    );
  }

  factory AppError.client({
    String title = 'Ajjaj',
    String message = 'Valami nem jó, próbáld újra később',
    String primaryText = 'Rendben',
  }) {
    return AppError(
      title: title,
      message: message,
      primaryText: primaryText,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppError &&
          runtimeType == other.runtimeType &&
          source == other.source;

  @override
  int get hashCode => source.hashCode;

  @override
  String toString() => source.toString();
}
