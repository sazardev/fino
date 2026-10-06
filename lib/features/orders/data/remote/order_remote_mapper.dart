import '../../../../core/money/money.dart';
import '../../../../core/sync/remote_marker.dart';
import '../../domain/entities/order.dart';

/// [Order] ↔ documento `teams/{team}/orders/{id}`.
abstract final class OrderRemoteMapper {
  static String collection(String teamId) => 'teams/$teamId/orders';

  /// Documento nuevo: las fechas de registro las pone el servidor.
  static Map<String, Object?> toCreateFields(Order order) => {
    'creditorId': order.creditorId,
    'concept': order.concept,
    'note': ?order.note,
    'total': order.total.cents,
    'spentAt': order.spentAt,
    'createdAt': RemoteMarker.serverTimestamp,
    'updatedAt': RemoteMarker.serverTimestamp,
  };

  /// Solo lo que se puede editar (quitar la nota la borra).
  static Map<String, Object?> toUpdateFields(Order order) => {
    'concept': order.concept,
    'note': order.note ?? RemoteMarker.fieldDelete,
    'total': order.total.cents,
    'spentAt': order.spentAt,
    'updatedAt': RemoteMarker.serverTimestamp,
  };

  static Order fromFields(
    String id,
    String teamId,
    Map<String, Object?> fields,
  ) => Order(
    id: id,
    teamId: teamId,
    creditorId: fields['creditorId']! as String,
    concept: fields['concept']! as String,
    note: fields['note'] as String?,
    total: Money(fields['total']! as int),
    spentAt: fields['spentAt']! as DateTime,
    createdAt: fields['createdAt']! as DateTime,
    updatedAt: fields['updatedAt']! as DateTime,
  );
}
