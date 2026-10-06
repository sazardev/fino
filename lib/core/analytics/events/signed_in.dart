import '../analytics_event.dart';

class SignedIn implements AnalyticsEvent {
  const new();

  @override
  String get name => 'login';

  @override
  Map<String, Object> get parameters => const {'method': 'google'};
}
