import '../../../../core/ids/id_generator.dart';
import '../../../../core/time/clock.dart';
import '../orders_repository.dart';
import '../use_cases/cancel_debt.dart';
import 'order_loader.dart';

/// El acreedor cancela (o perdona) una deuda pendiente (SPEC §6.5).
class CancelDebtCommand {
  const new(this._repo, this._newId, this._clock);

  final OrdersRepository _repo;
  final IdGenerator _newId;
  final Clock _clock;

  Future<void> call({
    required String actorId,
    required String debtId,
    String? note,
  }) async {
    final loader = OrderLoader(_repo);
    final debt = await loader.debt(debtId);
    final changes = CancelDebt(_newId)(
      actorId: actorId,
      debt: debt,
      order: await loader.order(debt.orderId),
      note: note,
      now: _clock(),
    );
    await _repo.apply(changes, actorId: actorId, teamId: debt.teamId);
  }
}
