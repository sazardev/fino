import 'package:fino/core/performance/noop_performance_monitor.dart';
import 'package:fino/core/performance/performance_monitor_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('on Linux the performance monitor is a no-op', () async {
    debugDefaultTargetPlatformOverride = TargetPlatform.linux;
    addTearDown(() => debugDefaultTargetPlatformOverride = null);

    final container = ProviderContainer();
    addTearDown(container.dispose);
    final monitor = container.read(performanceMonitorProvider);

    expect(monitor, isA<NoopPerformanceMonitor>());
    await monitor.setCollectionEnabled(enabled: true);
  });
}
