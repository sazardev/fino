import 'package:fino/core/ids/id_generator.dart';
import 'package:fino/core/money/money.dart';
import 'package:fino/features/orders/domain/entities/debt.dart';
import 'package:fino/features/orders/domain/entities/order.dart';
import 'package:fino/features/orders/domain/enums/debt_status.dart';
import 'package:fino/features/orders/domain/failures/order_failure.dart';
import 'package:fino/features/orders/domain/failures/order_failure_reason.dart';
import 'package:flutter_test/flutter_test.dart';

final t0 = DateTime.utc(2026, 10, 6, 12);

/// Pesos enteros como [Money].
Money pesos(int amount) => Money(amount * 100);

/// Ids `id1`, `id2`… en orden: pruebas deterministas.
IdGenerator sequentialIds() {
  var n = 0;
  return () => 'id${++n}';
}

Order buildOrder({
  String id = 'o1',
  String creditorId = 'omar',
  Money? total,
  String concept = 'Café',
}) => Order(
  id: id,
  teamId: 't1',
  creditorId: creditorId,
  concept: concept,
  total: total ?? pesos(300),
  spentAt: t0,
  createdAt: t0,
  updatedAt: t0,
);

Debt buildDebt({
  String id = 'd1',
  String orderId = 'o1',
  String creditorId = 'omar',
  String debtorId = 'ana',
  Money? amount,
  DebtStatus status = DebtStatus.pending,
  String? paymentId,
}) => Debt(
  id: id,
  orderId: orderId,
  teamId: 't1',
  creditorId: creditorId,
  debtorId: debtorId,
  amount: amount ?? pesos(60),
  status: status,
  createdAt: t0,
  updatedAt: t0,
  paymentId: paymentId,
);

Matcher throwsOrder(OrderFailureReason reason) =>
    throwsA(isA<OrderFailure>().having((e) => e.reason, 'reason', reason));
