import 'dart:async';

import 'package:flutter/foundation.dart';

import '../core/crash_reporting/crash_reporter.dart';
import '../core/logging/app_logger.dart';

/// Routes framework and uncaught async errors to the [logger] and, when there
/// is one, to the [crashReporter].
void installErrorHandlers(AppLogger logger, {CrashReporter? crashReporter}) {
  final presentError = FlutterError.presentError;
  FlutterError.onError = (details) {
    logger.error('Flutter error', details.exception, details.stack);
    unawaited(crashReporter?.recordError(details.exception, details.stack));
    presentError(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    logger.error('Uncaught error', error, stack);
    unawaited(crashReporter?.recordError(error, stack, fatal: true));
    return true;
  };
}
