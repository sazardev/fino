import '../../../../core/notifications/intent/notification_intent.dart';
import 'notice_record.dart';
import 'skipped_recipient.dart';

/// Resultado de enviar un aviso: a quién sí llegó y a quién se omitió.
final class NoticeResult {
  const new({
    required this.notifications,
    required this.skipped,
    required this.record,
  });

  final List<NotificationIntent> notifications;
  final List<SkippedRecipient> skipped;

  /// `null` si todos los destinatarios estaban en espera.
  final NoticeRecord? record;
}
