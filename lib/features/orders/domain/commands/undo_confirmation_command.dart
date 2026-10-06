import '../../../../core/ids/id_generator.dart';
import '../../../../core/time/clock.dart';
import '../orders_repository.dart';
import '../team_directory.dart';
import '../use_cases/undo_confirmation.dart';
import 'order_loader.dart';

/// El acreedor deshace una confirmación equivocada (SPEC D4).
class UndoConfirmationCommand {
  const new(this._repo, this._directory, this._newId, this._clock);

  final OrdersRepository _repo;
  final TeamDirectory _directory;
  final IdGenerator _newId;
  final Clock _clock;

  Future<void> call({required String actorId, required String debtId}) async {
    final loader = OrderLoader(_repo);
    final debt = await loader.debt(debtId);
    final members = await _directory.memberIds(debt.teamId);
    final changes = UndoConfirmation(_newId)(
      actorId: actorId,
      debt: debt,
      order: await loader.order(debt.orderId),
      debtorIsMember: members.contains(debt.debtorId),
      now: _clock(),
    );
    await _repo.apply(changes, actorId: actorId, teamId: debt.teamId);
  }
}
