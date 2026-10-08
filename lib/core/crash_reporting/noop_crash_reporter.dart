import 'crash_reporter.dart';

/// Where Firebase Crashlytics does not exist (Linux): reports nothing.
class NoopCrashReporter implements CrashReporter {
  const new();

  @override
  Future<void> setCollectionEnabled({required bool enabled}) async {}

  @override
  Future<void> recordError(
    Object error,
    StackTrace? stack, {
    bool fatal = false,
  }) async {}
}
