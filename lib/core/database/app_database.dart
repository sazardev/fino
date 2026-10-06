import 'package:drift/drift.dart';

import '../../features/inbox/data/daos/inbox_dao.dart';
import '../../features/inbox/data/tables/inbox_notifications.dart';
import '../../features/notices/data/daos/notice_records_dao.dart';
import '../../features/notices/data/tables/notice_records.dart';
import '../../features/notices/domain/enums/notice_template.dart';
import '../../features/orders/data/daos/debts_dao.dart';
import '../../features/orders/data/daos/ledger_dao.dart';
import '../../features/orders/data/daos/orders_dao.dart';
import '../../features/orders/data/daos/payments_dao.dart';
import '../../features/orders/data/tables/debts.dart';
import '../../features/orders/data/tables/ledger_entries.dart';
import '../../features/orders/data/tables/orders.dart';
import '../../features/orders/data/tables/payments.dart';
import '../../features/orders/domain/enums/debt_status.dart';
import '../../features/orders/domain/enums/ledger_event_type.dart';
import '../../features/teams/data/daos/teams_dao.dart';
import '../../features/teams/data/payout_method_type.dart';
import '../../features/teams/data/tables/payout_methods.dart';
import '../../features/teams/data/tables/team_members.dart';
import '../../features/teams/data/tables/teams.dart';
import '../../features/teams/domain/enums/team_role.dart';
import '../notifications/intent/notification_kind.dart';
import '../notifications/intent/notification_target_type.dart';
import 'converters/string_list_converter.dart';
import 'daos/outbox_dao.dart';
import 'outbox_operation.dart';
import 'tables/outbox_entries.dart';

part 'app_database.g.dart';

/// The app's local source of truth. Bump [schemaVersion] with a migration and
/// a schema dump (`drift_schemas/`) on every change.
///
/// This is the one place that composes every feature's tables (Drift needs a
/// single database class); each feature still owns its tables and DAOs.
@DriftDatabase(
  tables: [
    OutboxEntries,
    Teams,
    TeamMembers,
    PayoutMethods,
    Orders,
    Debts,
    Payments,
    LedgerEntries,
    NoticeRecords,
    InboxNotifications,
  ],
  daos: [
    OutboxDao,
    TeamsDao,
    OrdersDao,
    DebtsDao,
    PaymentsDao,
    LedgerDao,
    NoticeRecordsDao,
    InboxDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  new(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 2) await _upgradeToV2(m);
    },
  );

  /// v2: lotes en el outbox y todo el modelo de equipos, pedidos y buzón.
  Future<void> _upgradeToV2(Migrator m) async {
    await m.addColumn(outboxEntries, outboxEntries.batchId);
    const existedInV1 = {'outbox_entries', 'outbox_next_attempt'};
    for (final entity in allSchemaEntities) {
      if (!existedInV1.contains(entity.entityName)) await m.create(entity);
    }
  }

  /// Borra todo lo local de un equipo (salí, me expulsaron o lo eliminaron).
  Future<void> purgeTeamData(String teamId) => transaction(() async {
    await ledgerDao.deleteTeamEntries(teamId);
    await paymentsDao.deleteTeamPayments(teamId);
    await debtsDao.deleteTeamDebts(teamId);
    await ordersDao.deleteTeamOrders(teamId);
    await noticeRecordsDao.deleteTeamRecords(teamId);
    await teamsDao.deleteTeam(teamId);
  });

  /// Deletes every row of every table (sign-out).
  Future<void> wipe() => transaction(() async {
    for (final table in allTables) {
      await delete(table).go();
    }
  });
}
