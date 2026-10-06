import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../tables/payments.dart';

part 'payments_dao.g.dart';

/// Consultas locales de pagos agrupados.
@DriftAccessor(tables: [Payments])
class PaymentsDao extends DatabaseAccessor<AppDatabase>
    with _$PaymentsDaoMixin {
  new(super.attachedDatabase);

  Future<void> upsertPayments(Iterable<PaymentsCompanion> rows) =>
      batch((b) => b.insertAllOnConflictUpdate(payments, rows.toList()));

  Future<PaymentRow?> findPayment(String paymentId) => (select(
    payments,
  )..where((p) => p.id.equals(paymentId))).getSingleOrNull();

  Future<List<PaymentRow>> findPayments(Iterable<String> ids) =>
      (select(payments)..where((p) => p.id.isIn(ids))).get();

  Stream<List<PaymentRow>> watchTeamPayments(String teamId) =>
      (select(payments)
            ..where((p) => p.teamId.equals(teamId))
            ..orderBy([(p) => OrderingTerm.desc(p.reportedAt)]))
          .watch();

  /// Pagos dirigidos a [creditorId] a los que aún no se les avisó (#13).
  Future<List<PaymentRow>> pendingReminders(String creditorId) =>
      (select(payments)..where(
            (p) =>
                p.creditorId.equals(creditorId) &
                p.awaitingConfirmationReminderSent.equals(false),
          ))
          .get();

  Future<Set<String>> idsOfTeam(String teamId) async => {
    for (final row in await (select(
      payments,
    )..where((p) => p.teamId.equals(teamId))).get())
      row.id,
  };

  Future<void> deletePayment(String paymentId) =>
      (delete(payments)..where((p) => p.id.equals(paymentId))).go();

  Future<void> deleteTeamPayments(String teamId) =>
      (delete(payments)..where((p) => p.teamId.equals(teamId))).go();
}
