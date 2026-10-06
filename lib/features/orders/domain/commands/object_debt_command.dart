import '../../../../core/ids/id_generator.dart';
import '../../../../core/time/clock.dart';
import '../orders_repository.dart';
import '../use_cases/object_debt.dart';
import 'order_loader.dart';

/// El deudor objeta su deuda con un comentario (SPEC D5).
class ObjectDebtCommand {
  const new(this._repo, this._newId, this._clock);

  final OrdersRepository _repo;
  final IdGenerator _newId;
  final Clock _clock;

  Future<void> call({
    required String actorId,
    required String debtId,
    required String comment,
  }) async {
    final loader = OrderLoader(_repo);
    final debt = await loader.debt(debtId);
    final changes = ObjectDebt(_newId)(
      actorId: actorId,
      debt: debt,
      order: await loader.order(debt.orderId),
      comment: comment,
      now: _clock(),
    );
    await _repo.apply(changes, actorId: actorId, teamId: debt.teamId);
  }
}
