import 'package:fino/core/notifications/inbox_write_planner.dart';
import 'package:fino/core/sync/remote_write.dart';
import 'package:fino/features/orders/data/remote/order_write_planner.dart';
import 'package:fino/features/orders/domain/entities/debt.dart';
import 'package:fino/features/orders/domain/entities/order.dart';
import 'package:fino/features/orders/domain/entities/order_change_set.dart';
import 'package:fino/features/orders/domain/entities/payment.dart';
import 'package:fino/features/orders/domain/enums/debt_status.dart';

import 'firestore_rest.dart';
import 'remote_write_adapter.dart';
import 'rules_world.dart';

/// Un repositorio de mentira: guarda en memoria lo que ya "pasó" y envía cada
/// acción de negocio, tal como la planea la app, a las reglas reales.
class ContractHarness {
  new(this.world);

  final RulesWorld world;
  final orders = <String, Order>{};
  final debts = <String, Debt>{};
  final payments = <String, Payment>{};
  var _n = 0;

  /// Ids únicos entre archivos de prueba (comparten emulador y usuarios).
  String newId() => '${world.id}-${++_n}';

  Future<RestResult> push(String actor, List<RemoteWrite> writes) =>
      world.as(actor, RemoteWriteAdapter.toRest(writes));

  /// Planea y envía un resultado de pedidos; si pasa, lo recuerda.
  Future<RestResult> pushOrders(String actor, OrderChangeSet changes) async {
    final after = {...debts, for (final debt in changes.debts) debt.id: debt};
    final live = {
      for (final debt in after.values)
        if (debt.creditorId == actor && debt.status.isLive) debt.debtorId,
    };
    final writes = [
      ...const OrderWritePlanner().plan(
        changes,
        actorId: actor,
        teamId: world.teamId,
        known: KnownIds(
          orders: orders.keys.toSet(),
          debts: debts.keys.toSet(),
          payments: payments.keys.toSet(),
        ),
        debtsById: after,
        liveDebtorIdsAfter: live,
      ),
      ...InboxWritePlanner(newId).plan(changes.notifications),
    ];
    final result = await push(actor, writes);
    if (result.allowed) {
      final order = changes.order;
      if (order != null) orders[order.id] = order;
      debts.addAll({for (final d in changes.debts) d.id: d});
      payments.addAll({for (final p in changes.payments) p.id: p});
    }
    return result;
  }

  List<Debt> debtsOf(String orderId) =>
      debts.values.where((d) => d.orderId == orderId).toList();

  List<Debt> withStatus(DebtStatus status) =>
      debts.values.where((d) => d.status == status).toList();
}
