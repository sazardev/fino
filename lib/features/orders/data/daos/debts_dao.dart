import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/enums/debt_status.dart';
import '../tables/debts.dart';

part 'debts_dao.g.dart';

const List<DebtStatus> _liveStatuses = [
  DebtStatus.pending,
  DebtStatus.paymentReported,
];

/// Consultas locales de deudas: las listas Debo / Me deben salen de aquí.
@DriftAccessor(tables: [Debts])
class DebtsDao extends DatabaseAccessor<AppDatabase> with _$DebtsDaoMixin {
  new(super.attachedDatabase);

  Future<void> upsertDebts(Iterable<DebtsCompanion> rows) =>
      batch((b) => b.insertAllOnConflictUpdate(debts, rows.toList()));

  Future<DebtRow?> findDebt(String debtId) =>
      (select(debts)..where((d) => d.id.equals(debtId))).getSingleOrNull();

  Future<List<DebtRow>> findDebts(Iterable<String> debtIds) =>
      (select(debts)..where((d) => d.id.isIn(debtIds))).get();

  Future<List<DebtRow>> debtsOfOrder(String orderId) =>
      (select(debts)..where((d) => d.orderId.equals(orderId))).get();

  Stream<List<DebtRow>> watchDebtsOfOrder(String orderId) =>
      (select(debts)
            ..where((d) => d.orderId.equals(orderId))
            ..orderBy([
              (d) => OrderingTerm.asc(d.createdAt),
              (d) => OrderingTerm.asc(d.id),
            ]))
          .watch();

  /// Todas las deudas del equipo (vista de equipo, solo lectura).
  Stream<List<DebtRow>> watchTeamDebts(String teamId) =>
      (select(debts)
            ..where((d) => d.teamId.equals(teamId))
            ..orderBy([(d) => OrderingTerm.desc(d.updatedAt)]))
          .watch();

  /// Deudas vivas donde [userId] es parte (como deudor o acreedor).
  Stream<List<DebtRow>> watchLiveDebtsOf(String userId) =>
      (select(debts)
            ..where(
              (d) =>
                  d.status.isInValues(_liveStatuses) &
                  (d.debtorId.equals(userId) | d.creditorId.equals(userId)),
            )
            ..orderBy([
              (d) => OrderingTerm.asc(d.createdAt),
              (d) => OrderingTerm.asc(d.id),
            ]))
          .watch();

  /// Historial: deudas confirmadas o canceladas donde [userId] es parte.
  Stream<List<DebtRow>> watchClosedDebtsOf(String userId) =>
      (select(debts)
            ..where(
              (d) =>
                  d.status.isNotInValues(_liveStatuses) &
                  (d.debtorId.equals(userId) | d.creditorId.equals(userId)),
            )
            ..orderBy([(d) => OrderingTerm.desc(d.updatedAt)]))
          .watch();

  Stream<List<DebtRow>> watchDebtsOfPayment(String paymentId) =>
      (select(debts)..where((d) => d.paymentId.equals(paymentId))).watch();

  /// Deudas ligadas a un pago.
  Future<List<DebtRow>> debtsOfPayment(String paymentId) =>
      (select(debts)..where((d) => d.paymentId.equals(paymentId))).get();

  /// Cuántas deudas vivas tiene [userId] en [teamId], por rol (SPEC §4.2).
  Future<({int asDebtor, int asCreditor})> liveCounts(
    String userId,
    String teamId,
  ) async {
    final rows =
        await (select(debts)..where(
              (d) =>
                  d.teamId.equals(teamId) & d.status.isInValues(_liveStatuses),
            ))
            .get();
    return (
      asDebtor: rows.where((d) => d.debtorId == userId).length,
      asCreditor: rows.where((d) => d.creditorId == userId).length,
    );
  }

  /// Deudas vivas que [creditorId] tiene por cobrar en el equipo.
  Future<List<DebtRow>> liveDebtsOfCreditor(String creditorId, String teamId) =>
      (select(debts)..where(
            (d) =>
                d.creditorId.equals(creditorId) &
                d.teamId.equals(teamId) &
                d.status.isInValues(_liveStatuses),
          ))
          .get();

  /// Deudores que, a ojos de [creditorId], siguen con una deuda viva en el
  /// equipo: quienes deben poder ver su método de cobro (SPEC M4).
  Future<Set<String>> liveDebtorIdsOfCreditor(
    String creditorId,
    String teamId,
  ) async => {
    for (final debt
        in await (select(debts)..where(
              (d) =>
                  d.creditorId.equals(creditorId) &
                  d.teamId.equals(teamId) &
                  d.status.isInValues(_liveStatuses),
            ))
            .get())
      debt.debtorId,
  };

  /// Cuántas deudas vivas hay en todo el equipo.
  Future<int> liveCountOfTeam(String teamId) {
    final count = debts.id.count();
    final query = selectOnly(debts)
      ..addColumns([count])
      ..where(
        debts.teamId.equals(teamId) & debts.status.isInValues(_liveStatuses),
      );
    return query.map((row) => row.read(count) ?? 0).getSingle();
  }

  Future<Set<String>> idsOfTeam(String teamId) async => {
    for (final row in await (select(
      debts,
    )..where((d) => d.teamId.equals(teamId))).get())
      row.id,
  };

  Future<void> deleteDebt(String debtId) =>
      (delete(debts)..where((d) => d.id.equals(debtId))).go();

  Future<void> deleteTeamDebts(String teamId) =>
      (delete(debts)..where((d) => d.teamId.equals(teamId))).go();
}
