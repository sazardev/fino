import '../../core/database/app_database.dart';
import '../../core/logging/app_logger.dart';
import '../../core/sync/pull/resilient_subscription.dart';
import '../../core/sync/pull/scoped_collection_applier.dart';
import '../../core/sync/remote_document.dart';
import '../../core/sync/remote_filter.dart';
import '../../core/sync/remote_gateway.dart';
import '../../features/notices/data/sync/notices_applier.dart';
import '../../features/orders/data/sync/debts_applier.dart';
import '../../features/orders/data/sync/ledger_applier.dart';
import '../../features/orders/data/sync/orders_applier.dart';
import '../../features/orders/data/sync/payments_applier.dart';
import '../../features/teams/data/sync/members_applier.dart';
import '../../features/teams/data/sync/payout_document_applier.dart';
import '../../features/teams/data/sync/team_document_applier.dart';
import 'creditor_payout_watchers.dart';

/// Baja a Drift todo lo de UN equipo: el equipo, sus miembros, pedidos,
/// deudas, pagos, la bitácora que me toca, mis avisos y los métodos de cobro
/// que puedo ver.
class TeamPull {
  new({
    required this.db,
    required this.gateway,
    required this.teamId,
    required this.userId,
    this.logger,
    this.onTeamGone,
  }) {
    _payouts = CreditorPayoutWatchers(
      db: db,
      gateway: gateway,
      teamId: teamId,
      userId: userId,
      logger: logger,
    );
    final team = TeamDocumentApplier(db, teamId);
    final mine = PayoutDocumentApplier(db, teamId, userId);
    _subscriptions = [
      _doc('team', team.path, (document) async {
        await team.apply(document);
        if (document == null) onTeamGone?.call();
      }),
      _doc('my payout', mine.path, mine.apply),
      _collection(
        'members',
        'teams/$teamId/members',
        MembersApplier(db, teamId),
      ),
      _collection('orders', 'teams/$teamId/orders', OrdersApplier(db, teamId)),
      _collection('debts', 'teams/$teamId/debts', DebtsApplier(db, teamId)),
      _collection(
        'payments',
        'teams/$teamId/payments',
        PaymentsApplier(db, teamId),
      ),
      _collection(
        'ledger (open)',
        'teams/$teamId/ledger',
        LedgerApplier(db, teamId),
        where: const [RemoteFilter.equal('confidential', false)],
      ),
      // Las reglas no filtran: la consulta debe pedir solo lo que puedo leer.
      _collection(
        'ledger (mine)',
        'teams/$teamId/ledger',
        LedgerApplier(db, teamId),
        where: [RemoteFilter.arrayContains('partyIds', userId)],
      ),
      _collection(
        'notices',
        'teams/$teamId/notices',
        NoticesApplier(db, teamId, userId),
        where: [RemoteFilter.equal('senderId', userId)],
      ),
    ];
  }

  final AppDatabase db;
  final RemoteGateway gateway;
  final String teamId;
  final String userId;
  final AppLogger? logger;

  /// Se llama cuando el equipo dejó de existir en el servidor.
  final void Function()? onTeamGone;

  late final CreditorPayoutWatchers _payouts;
  late final List<ResilientSubscription> _subscriptions;

  void start() {
    for (final subscription in _subscriptions) {
      subscription.start();
    }
    _payouts.start();
  }

  void stop() {
    for (final subscription in _subscriptions) {
      subscription.stop();
    }
    _payouts.stop();
  }

  /// Vuelve a bajar todo: reconcilia lo local con el servidor.
  void restart() {
    for (final subscription in _subscriptions) {
      subscription.restart();
    }
    _payouts.restart();
  }

  ResilientSubscription _doc(
    String name,
    String path,
    Future<void> Function(RemoteDocument?) apply,
  ) => ResilientSubscription(
    name: '$name $teamId',
    open: () => gateway.watchDocument(path).asyncMap(apply),
    logger: logger,
  );

  ResilientSubscription _collection(
    String name,
    String path,
    ScopedCollectionApplier applier, {
    List<RemoteFilter> where = const [],
  }) => ResilientSubscription(
    name: '$name $teamId',
    open: () =>
        gateway.watchCollection(path, where: where).asyncMap(applier.apply),
    logger: logger,
  );
}
