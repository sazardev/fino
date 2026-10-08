import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'crash_reporter.dart';

class FirebaseCrashReporter implements CrashReporter {
  new(this._crashlytics);

  final FirebaseCrashlytics _crashlytics;

  @override
  Future<void> setCollectionEnabled({required bool enabled}) =>
      _crashlytics.setCrashlyticsCollectionEnabled(enabled);

  @override
  Future<void> recordError(
    Object error,
    StackTrace? stack, {
    bool fatal = false,
  }) => _crashlytics.recordError(error, stack, fatal: fatal);
}
