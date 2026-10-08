import 'package:fino/core/crash_reporting/crash_reporter.dart';

/// Remembers what was reported, sends nothing.
class RecordingCrashReporter implements CrashReporter {
  final errors = <({Object error, StackTrace? stack, bool fatal})>[];
  bool? collectionEnabled;

  @override
  Future<void> recordError(
    Object error,
    StackTrace? stack, {
    bool fatal = false,
  }) async => errors.add((error: error, stack: stack, fatal: fatal));

  @override
  Future<void> setCollectionEnabled({required bool enabled}) async =>
      collectionEnabled = enabled;
}
