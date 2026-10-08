/// Collects app performance traces. The app talks to this, never to Firebase
/// Performance.
abstract interface class PerformanceMonitor {
  Future<void> setCollectionEnabled({required bool enabled});
}
