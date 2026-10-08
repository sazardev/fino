import 'package:firebase_performance/firebase_performance.dart';

import 'performance_monitor.dart';

class FirebasePerformanceMonitor implements PerformanceMonitor {
  new(this._performance);

  final FirebasePerformance _performance;

  @override
  Future<void> setCollectionEnabled({required bool enabled}) =>
      _performance.setPerformanceCollectionEnabled(enabled);
}
