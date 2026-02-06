import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

abstract class Log {
  static void info(String message) {
    _log('info', message);
  }

  static void warn(String message) {
    _log('warn', message);
  }

  static void http(String message) {
    _log('http', message);
  }

  static void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    _log('debug', message, error, stackTrace);
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _log('error', message, error, stackTrace);
  }

  static void _log(String type, String message, [dynamic error, StackTrace? stackTrace]) {
    if (_isProductionMode()) {
      return;
    }

    final formattedText = '${type.toUpperCase()} => $message';

    switch (type) {
      case 'warn':
        developer.log('\x1B[33m$formattedText\x1B[0m');
        break;
      case 'error':
        developer.log('\x1B[31m$formattedText\x1B[0m', error: error, stackTrace: stackTrace);
        break;
      case 'debug':
        developer.log('\x1B[36m$formattedText\x1B[0m', error: error, stackTrace: stackTrace);
        break;
      case 'http':
        developer.log('\x1B[35m$formattedText\x1B[0m', error: error, stackTrace: stackTrace);
        break;
      default:
        developer.log('\x1B[32m$formattedText\x1B[0m');
        break;
    }
  }

  static bool _isProductionMode() {
    return kDebugMode == false;
  }
}
