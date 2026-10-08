import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'crash_reporter.dart';
import 'create_crash_reporter.dart';

part 'crash_reporter_provider.g.dart';

/// The app-wide crash reporter (overridden in bootstrap with the instance the
/// error handlers already hold, so there is a single one).
@Riverpod(keepAlive: true)
CrashReporter crashReporter(Ref ref) => createCrashReporter();
