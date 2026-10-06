import 'package:freezed_annotation/freezed_annotation.dart';

import '../../money/money.dart';
import 'notification_kind.dart';
import 'notification_target.dart';

part 'notification_intent.freezed.dart';

/// Lo que el negocio decidió avisar. El texto final y el envío (push + buzón)
/// son de capas externas; aquí solo viajan los datos del evento.
///
/// Campos opcionales según [kind]:
/// - [amount]: monto relevante (deuda, total del pago, total confirmado).
/// - [concept]: concepto del primer pedido involucrado.
/// - [debtCount]: deudas involucradas (confirmadas en `paymentReviewed`).
/// - [rejectedCount]: deudas rechazadas en `paymentReviewed`.
/// - [note]: motivo o texto libre (rechazo, objeción, aviso).
/// - [templateKey]: plantilla del aviso (el texto lo pone la capa de UI).
@freezed
abstract class NotificationIntent with _$NotificationIntent {
  const factory({
    required NotificationKind kind,
    required String recipientId,
    required String actorId,
    required String teamId,
    required NotificationTarget target,
    Money? amount,
    String? concept,
    int? debtCount,
    int? rejectedCount,
    String? note,
    String? templateKey,
  }) = _NotificationIntent;
}
