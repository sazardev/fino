import 'dart:ui';

import 'package:fino/bootstrap/install_error_handlers.dart';
import 'package:fino/core/logging/app_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/recording_crash_reporter.dart';

void main() {
  const logger = AppLogger(verbose: false);
  late FlutterExceptionHandler? previousFlutterHandler;
  late ErrorCallback? previousPlatformHandler;

  setUp(() {
    previousFlutterHandler = FlutterError.onError;
    previousPlatformHandler = PlatformDispatcher.instance.onError;
  });

  tearDown(() {
    FlutterError.onError = previousFlutterHandler;
    PlatformDispatcher.instance.onError = previousPlatformHandler;
  });

  test(
    'a Flutter error goes to the crash reporter, not marked as fatal',
    () async {
      final reporter = RecordingCrashReporter();
      installErrorHandlers(logger, crashReporter: reporter);

      FlutterError.onError!(
        FlutterErrorDetails(
          exception: StateError('boom'),
          stack: StackTrace.current,
        ),
      );
      await Future<void>.delayed(Duration.zero);

      expect(reporter.errors, hasLength(1));
      expect(reporter.errors.single.error, isA<StateError>());
      expect(reporter.errors.single.fatal, isFalse);
    },
  );

  test('an uncaught async error is reported as fatal', () async {
    final reporter = RecordingCrashReporter();
    installErrorHandlers(logger, crashReporter: reporter);

    final handled = PlatformDispatcher.instance.onError!(
      ArgumentError('nope'),
      StackTrace.current,
    );
    await Future<void>.delayed(Duration.zero);

    expect(handled, isTrue);
    expect(reporter.errors, hasLength(1));
    expect(reporter.errors.single.error, isA<ArgumentError>());
    expect(reporter.errors.single.fatal, isTrue);
  });

  test('without a reporter the handlers still swallow async errors', () {
    installErrorHandlers(logger);

    final handled = PlatformDispatcher.instance.onError!(
      ArgumentError('nope'),
      StackTrace.current,
    );

    expect(handled, isTrue);
  });
}
