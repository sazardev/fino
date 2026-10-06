/// A typed analytics event: the only way the app reports usage.
abstract interface class AnalyticsEvent {
  String get name;

  Map<String, Object> get parameters;
}
