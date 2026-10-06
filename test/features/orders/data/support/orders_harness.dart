import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:fino/core/database/app_database.dart';
import 'package:fino/core/ids/id_generator.dart';
import 'package:fino/core/sync/remote_write.dart';
import 'package:fino/features/orders/data/local_orders_repository.dart';
import 'package:fino/features/orders/data/local_team_directory.dart';
import 'package:fino/features/orders/domain/commands/add_debtors_command.dart';
import 'package:fino/features/orders/domain/commands/cancel_debt_command.dart';
import 'package:fino/features/orders/domain/commands/cancel_order_command.dart';
import 'package:fino/features/orders/domain/commands/change_order_total_command.dart';
import 'package:fino/features/orders/domain/commands/create_order_command.dart';
import 'package:fino/features/orders/domain/commands/edit_order_details_command.dart';
import 'package:fino/features/orders/domain/commands/object_debt_command.dart';
import 'package:fino/features/orders/domain/commands/redistribute_pending_command.dart';
import 'package:fino/features/orders/domain/commands/remind_stale_payments_command.dart';
import 'package:fino/features/orders/domain/commands/report_payment_command.dart';
import 'package:fino/features/orders/domain/commands/retract_payment_command.dart';
import 'package:fino/features/orders/domain/commands/review_debts_command.dart';
import 'package:fino/features/orders/domain/commands/undo_confirmation_command.dart';
import 'package:fino/features/orders/domain/commands/update_debt_amount_command.dart';
import 'package:fino/features/teams/data/payout_method_type.dart';
import 'package:fino/features/teams/domain/enums/team_role.dart';

/// Un dispositivo de mentira: base en memoria + repositorio + comandos, con
/// reloj e ids deterministas. Siembra el equipo `t1` (omar, ana, beto, cris;
/// omar con método de cobro).
class OrdersHarness {
  new _(this.db, this.repo, this.directory, this.now, this.newId);

  final AppDatabase db;
  final LocalOrdersRepository repo;
  final LocalTeamDirectory directory;
  final DateTime Function() now;
  final IdGenerator newId;

  static Future<OrdersHarness> create({
    DateTime Function()? clock,
    bool omarHasPayout = true,
  }) async {
    final db = AppDatabase(NativeDatabase.memory());
    var n = 0;
    String newId() => 'id${++n}';
    final now = clock ?? () => DateTime.utc(2026, 10, 6, 12);
    final harness = OrdersHarness._(
      db,
      LocalOrdersRepository(db, newId, now),
      LocalTeamDirectory(db),
      now,
      newId,
    );
    await harness._seedTeam(omarHasPayout);
    return harness;
  }

  Future<void> _seedTeam(bool omarHasPayout) async {
    for (final user in ['omar', 'ana', 'beto', 'cris']) {
      await db.teamsDao.upsertMember(
        TeamMembersCompanion.insert(
          teamId: 't1',
          userId: user,
          role: user == 'omar' ? TeamRole.admin : TeamRole.member,
          joinedAt: now(),
          displayName: user,
        ),
      );
    }
    if (omarHasPayout) {
      await db.teamsDao.upsertPayoutMethod(
        PayoutMethodsCompanion.insert(
          teamId: 't1',
          userId: 'omar',
          type: PayoutMethodType.clabe,
          number: '012180000112345671',
          bankName: const Value('BBVA'),
        ),
      );
    }
  }

  CreateOrderCommand get createOrder =>
      CreateOrderCommand(repo, directory, newId, now);
  ReportPaymentCommand get reportPayment =>
      ReportPaymentCommand(repo, directory, newId, now);
  RetractPaymentCommand get retractPayment =>
      RetractPaymentCommand(repo, newId, now);
  ReviewDebtsCommand get reviewDebts => ReviewDebtsCommand(repo, newId, now);
  UndoConfirmationCommand get undoConfirmation =>
      UndoConfirmationCommand(repo, directory, newId, now);
  CancelDebtCommand get cancelDebt => CancelDebtCommand(repo, newId, now);
  CancelOrderCommand get cancelOrder => CancelOrderCommand(repo, newId, now);
  ObjectDebtCommand get objectDebt => ObjectDebtCommand(repo, newId, now);
  UpdateDebtAmountCommand get updateAmount =>
      UpdateDebtAmountCommand(repo, newId, now);
  AddDebtorsCommand get addDebtors =>
      AddDebtorsCommand(repo, directory, newId, now);
  RedistributePendingCommand get redistribute =>
      RedistributePendingCommand(repo, newId, now);
  EditOrderDetailsCommand get editDetails =>
      EditOrderDetailsCommand(repo, newId, now);
  ChangeOrderTotalCommand get changeTotal =>
      ChangeOrderTotalCommand(repo, newId, now);
  RemindStalePaymentsCommand get remindStale =>
      RemindStalePaymentsCommand(repo, now);

  /// Los lotes pendientes en el outbox, en orden (cada uno = una acción).
  Future<List<List<RemoteWrite>>> batches() async {
    final entries = await db.select(db.outboxEntries).get();
    final ids = <String>[];
    for (final entry in entries) {
      if (!ids.contains(entry.batchId)) ids.add(entry.batchId);
    }
    return [for (final id in ids) await db.outboxDao.writesOfBatch(id)];
  }

  Future<void> close() => db.close();
}
