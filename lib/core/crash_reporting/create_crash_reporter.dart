import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../platform/crash_reporting_supported.dart';
import 'crash_reporter.dart';
import 'firebase_crash_reporter.dart';
import 'noop_crash_reporter.dart';

/// The flavor's crash reporter: Firebase where Crashlytics exists (Android,
/// iOS, macOS), nothing on web or Linux.
CrashReporter createCrashReporter() => crashReportingSupported
    ? FirebaseCrashReporter(FirebaseCrashlytics.instance)
    : const NoopCrashReporter();
