import '../money/money.dart';
import '../sync/remote_marker.dart';
import 'intent/notification_intent.dart';
import 'intent/notification_kind.dart';
import 'intent/notification_target.dart';
import 'intent/notification_target_type.dart';

/// La forma de un documento del buzón: `users/{uid}/inbox/{id}`.
abstract final class InboxDocument {
  static String collectionOf(String userId) => 'users/$userId/inbox';

  /// Campos para crear el aviso (nulos omitidos; la hora la pone el servidor).
  static Map<String, Object?> toFields(NotificationIntent intent) => {
    'kind': intent.kind.name,
    'actorId': intent.actorId,
    'teamId': intent.teamId,
    'targetType': intent.target.type.name,
    'targetId': intent.target.id,
    'amountCents': ?intent.amount?.cents,
    'concept': ?intent.concept,
    'debtCount': ?intent.debtCount,
    'rejectedCount': ?intent.rejectedCount,
    'note': ?intent.note,
    'templateKey': ?intent.templateKey,
    'createdAt': RemoteMarker.serverTimestamp,
  };

  /// El aviso tal como llega de Firestore.
  static NotificationIntent fromFields(
    Map<String, Object?> fields, {
    required String recipientId,
  }) => NotificationIntent(
    kind: NotificationKind.values.byName(fields['kind']! as String),
    recipientId: recipientId,
    actorId: fields['actorId']! as String,
    teamId: fields['teamId']! as String,
    target: NotificationTarget(
      NotificationTargetType.values.byName(fields['targetType']! as String),
      fields['targetId']! as String,
    ),
    amount: switch (fields['amountCents']) {
      final int cents => Money(cents),
      _ => null,
    },
    concept: fields['concept'] as String?,
    debtCount: fields['debtCount'] as int?,
    rejectedCount: fields['rejectedCount'] as int?,
    note: fields['note'] as String?,
    templateKey: fields['templateKey'] as String?,
  );
}
