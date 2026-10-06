import '../../../../core/ids/id_generator.dart';
import '../../../../core/money/money.dart';
import '../../../../core/time/clock.dart';
import '../orders_repository.dart';
import '../team_directory.dart';
import '../use_cases/add_debtors.dart';
import 'order_loader.dart';

/// El acreedor agrega deudores a un pedido abierto (SPEC §5.5).
class AddDebtorsCommand {
  const new(this._repo, this._directory, this._newId, this._clock);

  final OrdersRepository _repo;
  final TeamDirectory _directory;
  final IdGenerator _newId;
  final Clock _clock;

  Future<void> call({
    required String actorId,
    required String orderId,
    required Map<String, Money> newDebtors,
  }) async {
    final order = await OrderLoader(_repo).order(orderId);
    final changes = AddDebtors(_newId)(
      actorId: actorId,
      order: order,
      debts: await _repo.debtsOfOrder(orderId),
      memberIds: await _directory.memberIds(order.teamId),
      newDebtors: newDebtors,
      now: _clock(),
    );
    await _repo.apply(changes, actorId: actorId, teamId: order.teamId);
  }
}
