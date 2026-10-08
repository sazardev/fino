import 'performance_monitor.dart';

/// Where Firebase Performance does not exist (Linux): collects nothing.
class NoopPerformanceMonitor implements PerformanceMonitor {
  const new();

  @override
  Future<void> setCollectionEnabled({required bool enabled}) async {}
}
