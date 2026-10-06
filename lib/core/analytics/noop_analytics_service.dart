import 'analytics_event.dart';
import 'analytics_service.dart';

/// Where Firebase Analytics does not exist (Linux): reports nothing.
class NoopAnalyticsService implements AnalyticsService {
  @override
  Future<void> setCollectionEnabled({required bool enabled}) async {}

  @override
  Future<void> log(AnalyticsEvent event) async {}
}
