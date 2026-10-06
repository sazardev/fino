import 'package:firebase_analytics/firebase_analytics.dart';

import 'analytics_event.dart';
import 'analytics_service.dart';

class FirebaseAnalyticsService implements AnalyticsService {
  new(this._analytics);

  final FirebaseAnalytics _analytics;

  @override
  Future<void> setCollectionEnabled({required bool enabled}) =>
      _analytics.setAnalyticsCollectionEnabled(enabled);

  @override
  Future<void> log(AnalyticsEvent event) =>
      _analytics.logEvent(name: event.name, parameters: event.parameters);
}
