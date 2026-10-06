import '../../../../core/ids/id_generator.dart';
import '../../../../core/time/clock.dart';
import '../orders_repository.dart';
import '../split/split_entry.dart';
import '../use_cases/redistribute_pending.dart';
import 'order_loader.dart';

/// "Re-repartir": vuelve a repartir solo lo que sigue pendiente (SPEC §5.5).
class RedistributePendingCommand {
  const new(this._repo, this._newId, this._clock);

  final OrdersRepository _repo;
  final IdGenerator _newId;
  final Clock _clock;

  Future<void> call({
    required String actorId,
    required String orderId,
    required bool creditorIncluded,
    required List<SplitEntry> entries,
  }) async {
    final order = await OrderLoader(_repo).order(orderId);
    final changes = RedistributePending(_newId)(
      actorId: actorId,
      order: order,
      debts: await _repo.debtsOfOrder(orderId),
      creditorIncluded: creditorIncluded,
      entries: entries,
      now: _clock(),
    );
    await _repo.apply(changes, actorId: actorId, teamId: order.teamId);
  }
}
