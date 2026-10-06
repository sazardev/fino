import 'package:freezed_annotation/freezed_annotation.dart';

import 'notification_target_type.dart';

/// Destino lógico de una notificación; la capa de datos lo traduce a ruta.
@immutable
final class NotificationTarget {
  const new(this.type, this.id);

  const new debt(String id) : this(NotificationTargetType.debt, id);

  const new payment(String id) : this(NotificationTargetType.payment, id);

  const new pay(String creditorId)
    : this(NotificationTargetType.pay, creditorId);

  const new history(String teamId)
    : this(NotificationTargetType.history, teamId);

  const new team(String teamId) : this(NotificationTargetType.team, teamId);

  final NotificationTargetType type;
  final String id;

  @override
  bool operator ==(Object other) =>
      other is NotificationTarget && other.type == type && other.id == id;

  @override
  int get hashCode => Object.hash(type, id);

  @override
  String toString() => 'NotificationTarget(${type.name}, $id)';
}
