import 'package:drift/drift.dart';
import 'package:fino/core/database/app_database.dart';
import 'package:fino/core/money/money.dart';
import 'package:fino/core/notifications/intent/notification_intent.dart';
import 'package:fino/core/notifications/intent/notification_kind.dart';
import 'package:fino/core/notifications/intent/notification_target.dart';
import 'package:fino/features/inbox/data/mappers/inbox_notification_mapper.dart';
import 'package:fino/features/inbox/domain/entities/inbox_notification.dart';
import 'package:fino/features/orders/data/mappers/debt_mapper.dart';
import 'package:fino/features/orders/data/mappers/order_mapper.dart';
import 'package:fino/features/orders/data/mappers/payment_mapper.dart';
import 'package:fino/features/orders/domain/entities/debt.dart';
import 'package:fino/features/orders/domain/entities/order.dart';
import 'package:fino/features/orders/domain/entities/payment.dart';
import 'package:fino/features/orders/domain/entities/payout_snapshot.dart';
import 'package:fino/features/orders/domain/enums/debt_status.dart';
import 'package:fino/features/teams/data/payout_method_type.dart';
import 'package:fino/features/teams/domain/enums/team_role.dart';

final seededAt = DateTime.utc(2026, 10, 6, 12);

/// Un equipo vivo para el usuario de prueba (`u1`, admin): Beto (`u2`) y
/// Carla (`u3`); un café que u1 pagó (Beto pendiente, Carla reportó) y una
/// comida que pagó Beto (u1 le debe). Más una notificación sin leer.
Future<void> seedFino(AppDatabase db) async {
  await db.teamsDao.upsertTeam(
    TeamsCompanion.insert(
      id: 't1',
      name: 'Oficina',
      adminId: 'u1',
      inviteCode: 'ABCD2345',
      createdAt: seededAt,
    ),
  );
  for (final (id, name) in [('u1', 'Ana'), ('u2', 'Beto'), ('u3', 'Carla')]) {
    await db.teamsDao.upsertMember(
      TeamMembersCompanion.insert(
        teamId: 't1',
        userId: id,
        role: id == 'u1' ? TeamRole.admin : TeamRole.member,
        joinedAt: seededAt,
        displayName: name,
      ),
    );
    await db.teamsDao.upsertPayoutMethod(
      PayoutMethodsCompanion.insert(
        teamId: 't1',
        userId: id,
        type: PayoutMethodType.clabe,
        number: '012180000112345671',
        bankName: const Value('BBVA'),
      ),
    );
  }
  await _order(db, 'o1', 'Café', 'u1', 30000);
  await _order(db, 'o2', 'Comida', 'u2', 40000);
  await _debt(db, 'd1', 'o1', 'u1', 'u2', DebtStatus.pending);
  await _debt(db, 'd2', 'o1', 'u1', 'u3', DebtStatus.paymentReported, 'p1');
  await _debt(db, 'd3', 'o2', 'u2', 'u1', DebtStatus.pending);
  await db.paymentsDao.upsertPayments([
    PaymentMapper.toCompanion(
      Payment(
        id: 'p1',
        teamId: 't1',
        creditorId: 'u1',
        debtorId: 'u3',
        debtIds: const ['d2'],
        payoutShown: const PayoutSnapshot(bankName: 'BBVA', last4: '5671'),
        reportedAt: seededAt,
      ),
    ),
  ]);
  await db.inboxDao.upsert(
    InboxNotificationMapper.toCompanion(
      InboxNotification(
        id: 'n1',
        createdAt: seededAt,
        intent: const NotificationIntent(
          kind: NotificationKind.orderDebtCreated,
          recipientId: 'u1',
          actorId: 'u2',
          teamId: 't1',
          target: NotificationTarget.debt('d3'),
          amount: Money(20000),
          concept: 'Comida',
        ),
      ),
    ),
  );
}

Future<void> _order(
  AppDatabase db,
  String id,
  String concept,
  String creditor,
  int cents,
) => db.ordersDao.upsertOrder(
  OrderMapper.toCompanion(
    Order(
      id: id,
      teamId: 't1',
      creditorId: creditor,
      concept: concept,
      total: Money(cents),
      spentAt: seededAt,
      createdAt: seededAt,
      updatedAt: seededAt,
    ),
  ),
);

Future<void> _debt(
  AppDatabase db,
  String id,
  String orderId,
  String creditor,
  String debtor,
  DebtStatus status, [
  String? paymentId,
]) => db.debtsDao.upsertDebts([
  DebtMapper.toCompanion(
    Debt(
      id: id,
      orderId: orderId,
      teamId: 't1',
      creditorId: creditor,
      debtorId: debtor,
      amount: const Money(10000),
      status: status,
      paymentId: paymentId,
      createdAt: seededAt,
      updatedAt: seededAt,
    ),
  ),
]);
