import 'dart:developer' as developer;

import 'ioc.dart';

void logMessage(Object? o) {
  IoC.logger.log(o);
}

void logSuccess(Object? o) {
  IoC.logger.log(o, level: 500);
}

void logWarning(Object? o) {
  IoC.logger.log(o, level: 900, tag: 'WARNING');
}

void logError(
  Object? error, {
  String? message,
  String tag = 'ERROR',
  StackTrace? stack,
}) {
  IoC.logger.logError(
    error,
    message: message,
    tag: tag,
    stack: stack,
  );
}

abstract class Logger {
  void log(
    Object? o, {
    String tag = '',
    int level = 300,
    bool showTimestamp = false,
  });

  void logError(
    Object? error, {
    String? message,
    String tag = 'ERROR',
    StackTrace? stack,
  });
}

class DebugLogger implements Logger {
  const DebugLogger();

  @override
  void log(
    Object? object, {
    String tag = '',
    int level = 300,
    bool showTimestamp = false,
  }) {
    final time = showTimestamp ? '${DateTime.now().toIso8601String()} -- ' : '';
    if (object is Iterable) {
      for (var o in object) {
        developer.log(
          '$time$o',
          name: tag,
          level: level,
        );
      }
    } else if (object is Map) {
      for (var i in object.entries) {
        developer.log(
          '$time${i.key} - ${i.value}',
          name: tag,
          level: level,
        );
      }
    } else {
      developer.log(
        '$time$object',
        name: tag,
        level: level,
      );
    }
  }

  @override
  void logError(
    Object? error, {
    String? message,
    String tag = 'ERROR',
    StackTrace? stack,
  }) {
    developer.log(
      message ?? 'Error',
      name: tag,
      error: error,
      stackTrace: stack,
      level: 1000,
    );
  }
}

class ReleaseLogger implements Logger {
  const ReleaseLogger();

  @override
  void log(
    Object? o, {
    String tag = '',
    int level = 300,
    bool showTimestamp = false,
  }) {}

  @override
  void logError(
    Object? error, {
    String? message,
    String tag = 'ERROR',
    StackTrace? stack,
  }) {}
}
