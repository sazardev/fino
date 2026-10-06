/// Android notification channels. Ids are API: never rename a shipped one.
abstract final class NotificationChannels {
  /// Also the FCM default channel (see AndroidManifest).
  static const defaultId = 'fino_default';
  static const defaultName = 'General';
  static const defaultDescription = 'Avisos y recordatorios de Fino';
}
