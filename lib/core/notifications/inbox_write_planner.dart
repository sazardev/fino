import '../database/outbox_operation.dart';
import '../ids/id_generator.dart';
import '../sync/remote_write.dart';
import 'inbox_document.dart';
import 'intent/notification_intent.dart';

/// Convierte avisos de negocio en escrituras al buzón de cada destinatario.
///
/// Las escrituras viajan en el mismo lote que la acción que las originó.
class InboxWritePlanner {
  const new(this._newId);

  final IdGenerator _newId;

  List<RemoteWrite> plan(Iterable<NotificationIntent> notifications) => [
    for (final intent in notifications)
      RemoteWrite(
        collection: InboxDocument.collectionOf(intent.recipientId),
        id: _newId(),
        operation: OutboxOperation.create,
        fields: InboxDocument.toFields(intent),
      ),
  ];
}
