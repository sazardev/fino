import 'entities/notice_record.dart';
import 'entities/notice_result.dart';

/// El registro de avisos del remitente. Offline-first.
abstract interface class NoticesRepository {
  Stream<List<NoticeRecord>> watchSent(String senderId, String teamId);

  /// El último aviso a cada destinatario desde [since] (límite de 1 h, A3).
  Future<Map<String, DateTime>> lastSentAt(
    String senderId,
    String teamId, {
    required DateTime since,
  });

  /// Guarda el aviso y deja su lote (registro + buzones) para el servidor.
  Future<void> apply(NoticeResult result);
}
