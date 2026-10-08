import 'package:fino/core/crash_reporting/crash_reporter_provider.dart';
import 'package:fino/core/crash_reporting/create_crash_reporter.dart';
import 'package:fino/core/crash_reporting/noop_crash_reporter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('on Linux the crash reporter is a no-op', () {
    debugDefaultTargetPlatformOverride = TargetPlatform.linux;
    addTearDown(() => debugDefaultTargetPlatformOverride = null);

    expect(createCrashReporter(), isA<NoopCrashReporter>());

    final container = ProviderContainer();
    addTearDown(container.dispose);
    expect(container.read(crashReporterProvider), isA<NoopCrashReporter>());
  });

  test('the no-op reporter ignores everything', () async {
    const reporter = NoopCrashReporter();

    await reporter.setCollectionEnabled(enabled: true);
    await reporter.recordError(StateError('boom'), StackTrace.current);
    await reporter.recordError(StateError('boom'), null, fatal: true);
  });
}
