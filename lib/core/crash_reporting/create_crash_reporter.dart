import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../platform/firebase_plugins_supported.dart';
import 'crash_reporter.dart';
import 'firebase_crash_reporter.dart';
import 'noop_crash_reporter.dart';

/// The flavor's crash reporter: Firebase on Android, nothing on Linux.
CrashReporter createCrashReporter() => firebasePluginsSupported
    ? FirebaseCrashReporter(FirebaseCrashlytics.instance)
    : const NoopCrashReporter();
