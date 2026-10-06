import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/money/money.dart';
import '../../domain/entities/order.dart';

/// Fila local ↔ [Order].
abstract final class OrderMapper {
  static Order toDomain(OrderRow row) => Order(
    id: row.id,
    teamId: row.teamId,
    creditorId: row.creditorId,
    concept: row.concept,
    note: row.note,
    total: Money(row.totalCents),
    spentAt: row.spentAt.toUtc(),
    createdAt: row.createdAt.toUtc(),
    updatedAt: row.updatedAt.toUtc(),
  );

  static OrdersCompanion toCompanion(Order order) => OrdersCompanion.insert(
    id: order.id,
    teamId: order.teamId,
    creditorId: order.creditorId,
    concept: order.concept,
    note: Value(order.note),
    totalCents: order.total.cents,
    spentAt: order.spentAt,
    createdAt: order.createdAt,
    updatedAt: order.updatedAt,
  );
}
