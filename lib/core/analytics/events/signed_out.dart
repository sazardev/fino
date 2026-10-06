import '../analytics_event.dart';

class SignedOut implements AnalyticsEvent {
  const new();

  @override
  String get name => 'sign_out';

  @override
  Map<String, Object> get parameters => const {};
}
