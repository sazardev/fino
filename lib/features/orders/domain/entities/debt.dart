import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/money/money.dart';
import '../enums/debt_status.dart';

part 'debt.freezed.dart';

/// Parte de un pedido asignada a un deudor (SPEC §6).
///
/// Siempre cuelga de un pedido; [paymentId] liga el pago que la reportó.
@freezed
abstract class Debt with _$Debt {
  const factory({
    required String id,
    required String orderId,
    required String teamId,
    required String creditorId,
    required String debtorId,
    required Money amount,
    required DebtStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? paymentId,
  }) = _Debt;
}
