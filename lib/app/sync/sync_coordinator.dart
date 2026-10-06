import '../../core/database/app_database.dart';
import '../../core/logging/app_logger.dart';
import '../../core/sync/outbox/outbox_processor.dart';
import '../../core/sync/outbox/outbox_pump.dart';
import '../../core/sync/outbox/outbox_rejection.dart';
import '../../core/sync/pull/resilient_subscription.dart';
import '../../core/sync/remote_change_kind.dart';
import '../../core/sync/remote_filter.dart';
import '../../core/sync/remote_gateway.dart';
import '../../core/sync/remote_snapshot.dart';
import '../../core/time/clock.dart';
import '../../features/inbox/data/sync/inbox_applier.dart';
import 'team_pull.dart';

/// Mantiene sincronizado a UN usuario con Firestore:
/// - **Subida**: el outbox sale en lotes atómicos (`OutboxPump`).
/// - **Bajada**: mis equipos (`members` donde soy yo) y, por cada uno, todo lo
///   suyo (`TeamPull`); más mi buzón.
///
/// Drift sigue siendo la fuente de verdad de la UI: aquí solo se reconcilia.
class SyncCoordinator {
  new({
    required this.db,
    required this.gateway,
    required this.userId,
    required this.clock,
    this.logger,
  }) {
    _pump = OutboxPump(
      dao: db.outboxDao,
      processor: OutboxProcessor(
        dao: db.outboxDao,
        gateway: gateway,
        clock: clock,
      ),
      clock: clock,
      onRejected: _onRejected,
      logger: logger,
    );
    _memberships = ResilientSubscription(
      name: 'memberships',
      open: () => gateway
          .watchGroup('members', where: [RemoteFilter.equal('userId', userId)])
          .asyncMap(_applyMemberships),
      logger: logger,
    );
    final inbox = InboxApplier(db, userId);
    _inbox = ResilientSubscription(
      name: 'inbox',
      open: () =>
          gateway.watchCollection('users/$userId/inbox').asyncMap(inbox.apply),
      logger: logger,
    );
  }

  final AppDatabase db;
  final RemoteGateway gateway;
  final String userId;
  final Clock clock;
  final AppLogger? logger;

  late final OutboxPump _pump;
  late final ResilientSubscription _memberships;
  late final ResilientSubscription _inbox;
  final _teams = <String, TeamPull>{};

  void start() {
    _pump.start();
    _memberships.start();
    _inbox.start();
  }

  void stop() {
    _pump.stop();
    _memberships.stop();
    _inbox.stop();
    for (final pull in _teams.values) {
      pull.stop();
    }
    _teams.clear();
  }

  /// Una pasada del outbox ahora (p. ej. al recuperar la conexión).
  Future<void> flushNow() => _pump.flushNow();

  Future<void> _applyMemberships(RemoteSnapshot snapshot) async {
    final remote = <String>{};
    for (final change in snapshot.changes) {
      final teamId = change.document.path.split('/')[1];
      remote.add(teamId);
      if (change.kind == RemoteChangeKind.removed) {
        await _forget(teamId);
      } else {
        _follow(teamId);
      }
    }
    if (!snapshot.isInitial) return;
    for (final teamId in await db.teamsDao.teamIdsOf(userId)) {
      if (!remote.contains(teamId) &&
          !await db.outboxDao.hasPendingForTeam(teamId)) {
        await _forget(teamId);
      }
    }
  }

  void _follow(String teamId) {
    _teams.putIfAbsent(
      teamId,
      () => TeamPull(
        db: db,
        gateway: gateway,
        teamId: teamId,
        userId: userId,
        logger: logger,
        onTeamGone: () => _forget(teamId),
      )..start(),
    );
  }

  /// Ya no soy miembro (salí, me expulsaron o lo eliminaron).
  Future<void> _forget(String teamId) async {
    _teams.remove(teamId)?.stop();
    await db.purgeTeamData(teamId);
  }

  /// Un lote rechazado: lo local de ese equipo debe volver a lo del servidor.
  Future<void> _onRejected(OutboxRejection rejection) async {
    for (final teamId in rejection.teamIds) {
      final pull = _teams[teamId];
      if (pull != null) {
        pull.restart();
      } else {
        await db.purgeTeamData(teamId);
      }
    }
  }
}
