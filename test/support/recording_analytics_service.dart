import 'package:fino/core/analytics/analytics_event.dart';
import 'package:fino/core/analytics/analytics_service.dart';

/// Remembers what was logged, sends nothing.
class RecordingAnalyticsService implements AnalyticsService {
  final events = <AnalyticsEvent>[];
  bool? collectionEnabled;

  @override
  Future<void> log(AnalyticsEvent event) async => events.add(event);

  @override
  Future<void> setCollectionEnabled({required bool enabled}) async =>
      collectionEnabled = enabled;
}
