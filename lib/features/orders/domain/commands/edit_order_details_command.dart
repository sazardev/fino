import '../../../../core/ids/id_generator.dart';
import '../../../../core/time/clock.dart';
import '../orders_repository.dart';
import '../use_cases/edit_order_details.dart';
import 'order_loader.dart';

/// El acreedor edita concepto, nota y fecha (SPEC §5.5).
class EditOrderDetailsCommand {
  const new(this._repo, this._newId, this._clock);

  final OrdersRepository _repo;
  final IdGenerator _newId;
  final Clock _clock;

  Future<void> call({
    required String actorId,
    required String orderId,
    required String concept,
    required DateTime spentAt,
    String? note,
  }) async {
    final order = await OrderLoader(_repo).order(orderId);
    final changes = EditOrderDetails(_newId)(
      actorId: actorId,
      order: order,
      concept: concept,
      note: note,
      spentAt: spentAt,
      now: _clock(),
    );
    await _repo.apply(changes, actorId: actorId, teamId: order.teamId);
  }
}
