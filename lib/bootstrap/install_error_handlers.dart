import 'package:flutter/foundation.dart';

import '../core/logging/app_logger.dart';

/// Routes framework and uncaught async errors to the [logger].
void installErrorHandlers(AppLogger logger) {
  final presentError = FlutterError.presentError;
  FlutterError.onError = (details) {
    logger.error('Flutter error', details.exception, details.stack);
    presentError(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    logger.error('Uncaught error', error, stack);
    return true;
  };
}
