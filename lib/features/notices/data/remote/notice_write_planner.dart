import '../../../../core/database/outbox_operation.dart';
import '../../../../core/sync/remote_marker.dart';
import '../../../../core/sync/remote_write.dart';
import '../../domain/entities/notice_result.dart';

/// Traduce el envío de un aviso en el registro del remitente (SPEC A5).
///
/// Las notificaciones a los destinatarios las planea el buzón.
class NoticeWritePlanner {
  const new();

  List<RemoteWrite> plan(NoticeResult result) {
    final record = result.record;
    if (record == null) return const [];
    return [
      RemoteWrite(
        collection: 'teams/${record.teamId}/notices',
        id: record.id,
        operation: OutboxOperation.create,
        fields: {
          'senderId': record.senderId,
          'recipientIds': record.recipientIds,
          'template': ?record.content.template?.name,
          'text': ?record.content.text,
          'sentAt': RemoteMarker.serverTimestamp,
        },
      ),
    ];
  }
}
