import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/money/money.dart';
import '../../domain/entities/debt.dart';

/// Fila local ↔ [Debt].
abstract final class DebtMapper {
  static Debt toDomain(DebtRow row) => Debt(
    id: row.id,
    orderId: row.orderId,
    teamId: row.teamId,
    creditorId: row.creditorId,
    debtorId: row.debtorId,
    amount: Money(row.amountCents),
    status: row.status,
    paymentId: row.paymentId,
    createdAt: row.createdAt.toUtc(),
    updatedAt: row.updatedAt.toUtc(),
  );

  static DebtsCompanion toCompanion(Debt debt) => DebtsCompanion.insert(
    id: debt.id,
    orderId: debt.orderId,
    teamId: debt.teamId,
    creditorId: debt.creditorId,
    debtorId: debt.debtorId,
    amountCents: debt.amount.cents,
    status: debt.status,
    paymentId: Value(debt.paymentId),
    createdAt: debt.createdAt,
    updatedAt: debt.updatedAt,
  );
}
