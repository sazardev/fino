import '../../../../core/ids/id_generator.dart';
import '../../../../core/money/money.dart';
import '../../../../core/time/clock.dart';
import '../orders_repository.dart';
import '../use_cases/update_debt_amount.dart';
import 'order_loader.dart';

/// El acreedor cambia el monto de una deuda pendiente (SPEC §5.5).
class UpdateDebtAmountCommand {
  const new(this._repo, this._newId, this._clock);

  final OrdersRepository _repo;
  final IdGenerator _newId;
  final Clock _clock;

  Future<void> call({
    required String actorId,
    required String debtId,
    required Money newAmount,
  }) async {
    final loader = OrderLoader(_repo);
    final debt = await loader.debt(debtId);
    final changes = UpdateDebtAmount(_newId)(
      actorId: actorId,
      order: await loader.order(debt.orderId),
      debt: debt,
      siblings: await _repo.debtsOfOrder(debt.orderId),
      newAmount: newAmount,
      now: _clock(),
    );
    await _repo.apply(changes, actorId: actorId, teamId: debt.teamId);
  }
}
