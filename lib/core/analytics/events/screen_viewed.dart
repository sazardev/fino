import '../analytics_event.dart';

class ScreenViewed implements AnalyticsEvent {
  const new(this.screen);

  /// The route's location, e.g. `/ajustes/apariencia`.
  final String screen;

  @override
  String get name => 'screen_view';

  @override
  Map<String, Object> get parameters => {'screen_name': screen};
}
