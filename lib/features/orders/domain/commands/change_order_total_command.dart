import '../../../../core/ids/id_generator.dart';
import '../../../../core/money/money.dart';
import '../../../../core/time/clock.dart';
import '../orders_repository.dart';
import '../use_cases/change_order_total.dart';
import 'order_loader.dart';

/// El acreedor cambia el monto total del pedido (SPEC §5.5).
class ChangeOrderTotalCommand {
  const new(this._repo, this._newId, this._clock);

  final OrdersRepository _repo;
  final IdGenerator _newId;
  final Clock _clock;

  Future<void> call({
    required String actorId,
    required String orderId,
    required Money newTotal,
  }) async {
    final order = await OrderLoader(_repo).order(orderId);
    final changes = ChangeOrderTotal(_newId)(
      actorId: actorId,
      order: order,
      debts: await _repo.debtsOfOrder(orderId),
      newTotal: newTotal,
      now: _clock(),
    );
    await _repo.apply(changes, actorId: actorId, teamId: order.teamId);
  }
}
