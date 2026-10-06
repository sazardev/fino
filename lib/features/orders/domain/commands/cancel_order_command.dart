import '../../../../core/ids/id_generator.dart';
import '../../../../core/time/clock.dart';
import '../orders_repository.dart';
import '../use_cases/cancel_order.dart';
import 'order_loader.dart';

/// El acreedor cancela el pedido completo (SPEC §6.6).
class CancelOrderCommand {
  const new(this._repo, this._newId, this._clock);

  final OrdersRepository _repo;
  final IdGenerator _newId;
  final Clock _clock;

  Future<void> call({
    required String actorId,
    required String orderId,
    String? note,
  }) async {
    final order = await OrderLoader(_repo).order(orderId);
    final changes = CancelOrder(_newId)(
      actorId: actorId,
      order: order,
      debts: await _repo.debtsOfOrder(orderId),
      note: note,
      now: _clock(),
    );
    await _repo.apply(changes, actorId: actorId, teamId: order.teamId);
  }
}
