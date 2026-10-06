import '../../../../core/format/date_label.dart';
import '../../domain/entities/notice_result.dart';

/// Cómo salió un aviso: a cuántos llegó y quién quedó en espera (A3).
abstract final class NoticeResultText {
  static String of(NoticeResult result, {required DateTime now}) {
    final sent = result.notifications.length;
    final skipped = result.skipped;
    final head = sent == 0
        ? 'No se envió'
        : 'Aviso enviado a ${sent == 1 ? '1 persona' : '$sent personas'}';
    if (skipped.isEmpty) return head;
    final retry = skipped
        .map((s) => s.retryAt)
        .reduce((a, b) => a.isAfter(b) ? a : b)
        .toLocal();
    final time = '${retry.hour}:${retry.minute.toString().padLeft(2, '0')}';
    final when = DateLabel.of(retry, now: now);
    return '$head · ${skipped.length} en espera hasta $when $time';
  }
}
