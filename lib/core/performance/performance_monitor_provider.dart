import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../firebase/firebase_performance_provider.dart';
import '../platform/firebase_plugins_supported_provider.dart';
import 'firebase_performance_monitor.dart';
import 'noop_performance_monitor.dart';
import 'performance_monitor.dart';

part 'performance_monitor_provider.g.dart';

@Riverpod(keepAlive: true)
PerformanceMonitor performanceMonitor(Ref ref) =>
    ref.watch(firebasePluginsSupportedFlagProvider)
    ? FirebasePerformanceMonitor(ref.watch(firebasePerformanceProvider))
    : const NoopPerformanceMonitor();
