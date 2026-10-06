import 'dart:math';

import 'package:drift/native.dart';
import 'package:fino/app/sync/sync_coordinator.dart';
import 'package:fino/core/database/app_database.dart';
import 'package:fino/core/sync/remote_gateway.dart';
import 'package:fino/features/inbox/data/local_inbox_repository.dart';
import 'package:fino/features/notices/data/local_notice_audience.dart';
import 'package:fino/features/notices/data/local_notices_repository.dart';
import 'package:fino/features/notices/domain/commands/send_notice_command.dart';
import 'package:fino/features/orders/data/local_orders_repository.dart';
import 'package:fino/features/orders/data/local_team_directory.dart';
import 'package:fino/features/orders/domain/commands/cancel_debt_command.dart';
import 'package:fino/features/orders/domain/commands/create_order_command.dart';
import 'package:fino/features/orders/domain/commands/report_payment_command.dart';
import 'package:fino/features/orders/domain/commands/review_debts_command.dart';
import 'package:fino/features/teams/data/local_live_debts_directory.dart';
import 'package:fino/features/teams/data/local_team_store.dart';
import 'package:fino/features/teams/data/remote_invite_lookup.dart';
import 'package:fino/features/teams/domain/commands/create_team_command.dart';
import 'package:fino/features/teams/domain/commands/delete_team_command.dart';
import 'package:fino/features/teams/domain/commands/join_team_command.dart';
import 'package:fino/features/teams/domain/commands/leave_team_command.dart';
import 'package:fino/features/teams/domain/commands/regenerate_invite_code_command.dart';
import 'package:fino/features/teams/domain/commands/set_payout_method_command.dart';
import 'package:fino/features/teams/domain/entities/invite_codes.dart';

import '../../support/switchable_gateway.dart';
import 'rules_gateway.dart';

final _random = Random.secure();

/// Un usuario con un dispositivo completo: su base local, sus repositorios y
/// comandos reales y su sincronización contra el emulador con las reglas
/// reales. Cada [uid] es único para que las pruebas paralelas no se pisen.
class E2eDevice {
  new _(this.uid, this.db, this.net, this.coordinator) {
    const now = DateTime.now;
    final orders = LocalOrdersRepository(db, newId, now);
    final directory = LocalTeamDirectory(db);
    store = LocalTeamStore(db, newId, now);
    final debts = LocalLiveDebtsDirectory(db);
    inbox = LocalInboxRepository(db, newId, now);
    ordersRepo = orders;
    createTeam = CreateTeamCommand(
      store,
      newId,
      () => InviteCodes.generate(_random),
      now,
    );
    joinTeam = JoinTeamCommand(store, RemoteInviteLookup(net), now);
    leaveTeam = LeaveTeamCommand(store, debts);
    deleteTeam = DeleteTeamCommand(store, debts);
    regenerateCode = RegenerateInviteCodeCommand(
      store,
      () => InviteCodes.generate(_random),
    );
    setPayoutMethod = SetPayoutMethodCommand(store);
    createOrder = CreateOrderCommand(orders, directory, newId, now);
    reportPayment = ReportPaymentCommand(orders, directory, newId, now);
    reviewDebts = ReviewDebtsCommand(orders, newId, now);
    cancelDebt = CancelDebtCommand(orders, newId, now);
    sendNotice = SendNoticeCommand(
      LocalNoticesRepository(db, newId, now),
      LocalNoticeAudience(db),
      newId,
      now,
    );
  }

  /// Un dispositivo para [name] (se le agrega un sufijo único).
  factory open(
    String name, {
    Duration poll = const Duration(milliseconds: 80),
  }) {
    final uid = '$name-${_random.nextInt(1 << 30)}';
    final db = AppDatabase(NativeDatabase.memory());
    final net = SwitchableGateway(gatewayFor(uid, poll: poll));
    return E2eDevice._(
      uid,
      db,
      net,
      SyncCoordinator(
        db: db,
        gateway: net as RemoteGateway,
        userId: uid,
        clock: () => DateTime.now().toUtc(),
      ),
    );
  }

  final String uid;
  final AppDatabase db;
  final SwitchableGateway net;
  final SyncCoordinator coordinator;

  late final LocalTeamStore store;
  late final LocalInboxRepository inbox;
  late final LocalOrdersRepository ordersRepo;
  late final CreateTeamCommand createTeam;
  late final JoinTeamCommand joinTeam;
  late final LeaveTeamCommand leaveTeam;
  late final DeleteTeamCommand deleteTeam;
  late final RegenerateInviteCodeCommand regenerateCode;
  late final SetPayoutMethodCommand setPayoutMethod;
  late final CreateOrderCommand createOrder;
  late final ReportPaymentCommand reportPayment;
  late final ReviewDebtsCommand reviewDebts;
  late final CancelDebtCommand cancelDebt;
  late final SendNoticeCommand sendNotice;

  static var _ids = 0;

  /// Ids únicos aunque varios dispositivos creen cosas a la vez.
  static String newId() {
    final stamp = DateTime.now().microsecondsSinceEpoch;
    return 'e$stamp-${++_ids}-${_random.nextInt(1 << 20)}';
  }

  void start() => coordinator.start();

  Future<void> close() async {
    coordinator.stop();
    await db.close();
  }
}

/// Reintenta [check] hasta que sea cierto o se acabe el tiempo.
Future<void> eventually(
  Future<bool> Function() check, {
  Duration timeout = const Duration(seconds: 15),
  String reason = 'condition',
}) async {
  final deadline = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(deadline)) {
    if (await check()) return;
    await Future<void>.delayed(const Duration(milliseconds: 60));
  }
  throw StateError('Timed out waiting for $reason');
}
