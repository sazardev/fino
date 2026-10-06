import '../../../../core/notifications/intent/notification_intent.dart';

/// A dónde lleva tocar una notificación (SPEC N3). Lo implementa la app.
abstract interface class InboxNavigator {
  Future<void> openTarget(NotificationIntent intent);
}
