import 'analytics_event.dart';

/// Reports usage. The app talks to this, never to Firebase Analytics.
abstract interface class AnalyticsService {
  Future<void> setCollectionEnabled({required bool enabled});

  Future<void> log(AnalyticsEvent event);
}
