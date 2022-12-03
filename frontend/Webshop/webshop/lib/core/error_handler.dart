import 'dart:io';

import 'package:api/api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../api/model_extensions.dart';
import '../app/logging.dart';
import 'app_error.dart';
import 'content.dart';
import 'exceptions.dart';

class ErrorHandler {
  final current = Content<AppError>();

  AppError? get error => current.value;

  void setError(
    dynamic e, {
    ErrorCallback? primaryCallback,
    ErrorCallback? secondaryCallback,
    ErrorCallback? retryCallback,
  }) {
    if (e is ApiException) {
      logError(e, tag: 'ERROR_HANDLER', message: e.message);
      e = _mapApiException(e);
    }

    if (e is AuthAbortedException) {
      return;
    }

    final appError = _create(e);
    appError.source = e;
    if (e is SocketException || e is NetworkException) {
      appError.primaryCallback = retryCallback;
      appError.secondaryCallback = secondaryCallback;
    } else if (e is PlatformException || e is InternalServerException) {
      appError.primaryCallback = retryCallback;
      appError.secondaryCallback = secondaryCallback;
    } else {
      appError.primaryCallback = primaryCallback;
      appError.secondaryCallback = secondaryCallback;
    }

    current.value = appError;
  }

  void primaryResolve() {
    current.value?.primaryCallback?.call();
    clear();
  }

  void secondaryResolve() {
    current.value?.secondaryCallback?.call();
    clear();
  }

  void clear() {
    current.value = null;
  }

  AppError _create(dynamic e) {
    switch (e.runtimeType) {
      case SocketException:
        return AppError.network();
      case AuthException:
        return AppError.client(
          message: 'Valami nem jó, próbáld újra később',
          primaryText: 'Rendben',
        );
      case PlatformException:
        {
          final pe = e as PlatformException;
          if (pe.code == 'network_error') {
            return AppError.network();
          } else {
            return AppError.server();
          }
        }
      case NetworkException:
        return AppError.network();
      case InternalServerException:
        return AppError.server();
      default:
        {
          final message =
              kDebugMode ? e.toString() : 'error_something_is_not_right';
          return AppError.client(title: 'hiba', message: message);
        }
    }
  }

  Exception _mapApiException(ApiException e) {
    if (isNetworkError(e.innerException)) {
      return NetworkException(e);
    } else if (HttpStatus.badRequest <= e.code) {
      return AppException(e);
    } else if (HttpStatus.internalServerError <= e.code) {
      return InternalServerException(e);
    } else {
      return AppException(e, message: "Unknown error");
    }
  }
}
