import 'dart:async';

import '../../core/database/app_database.dart';
import '../../core/logging/app_logger.dart';
import '../../core/sync/pull/resilient_subscription.dart';
import '../../core/sync/remote_gateway.dart';
import '../../features/teams/data/sync/payout_document_applier.dart';

/// Escucha el método de cobro de cada acreedor al que le debo algo (SPEC M4).
///
/// Las reglas solo me lo dejan leer mientras tengo una deuda viva con él: al
/// saldarse la última, se deja de escuchar y se borra lo guardado.
class CreditorPayoutWatchers {
  new({
    required this.db,
    required this.gateway,
    required this.teamId,
    required this.userId,
    this.logger,
  });

  final AppDatabase db;
  final RemoteGateway gateway;
  final String teamId;
  final String userId;
  final AppLogger? logger;

  final _watching = <String, ResilientSubscription>{};
  // ignore: cancel_subscriptions, cancelled in stop()
  StreamSubscription<List<DebtRow>>? _debts;

  void start() {
    _debts ??= db.debtsDao.watchLiveDebtsOf(userId).listen(_sync);
  }

  void stop() {
    final debts = _debts;
    if (debts != null) unawaited(debts.cancel());
    _debts = null;
    for (final watcher in _watching.values) {
      watcher.stop();
    }
    _watching.clear();
  }

  void restart() {
    for (final watcher in _watching.values) {
      watcher.restart();
    }
  }

  void _sync(List<DebtRow> live) {
    final creditors = {
      for (final debt in live)
        if (debt.teamId == teamId && debt.debtorId == userId) debt.creditorId,
    };
    for (final id in creditors.difference(_watching.keys.toSet())) {
      _watching[id] = _watch(id)..start();
    }
    for (final id in _watching.keys.toSet().difference(creditors)) {
      _watching.remove(id)?.stop();
      unawaited(db.teamsDao.removePayoutMethod(teamId, id));
    }
  }

  ResilientSubscription _watch(String creditorId) {
    final applier = PayoutDocumentApplier(db, teamId, creditorId);
    return ResilientSubscription(
      name: 'payout $teamId/$creditorId',
      open: () => gateway.watchDocument(applier.path).asyncMap(applier.apply),
      logger: logger,
    );
  }
}
