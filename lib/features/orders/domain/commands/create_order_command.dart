import '../../../../core/ids/id_generator.dart';
import '../../../../core/money/money.dart';
import '../../../../core/time/clock.dart';
import '../entities/order.dart';
import '../orders_repository.dart';
import '../split/split_entry.dart';
import '../team_directory.dart';
import '../use_cases/create_order.dart';

/// Registra un pedido nuevo del usuario como acreedor (SPEC §5).
class CreateOrderCommand {
  const new(this._repo, this._directory, this._newId, this._clock);

  final OrdersRepository _repo;
  final TeamDirectory _directory;
  final IdGenerator _newId;
  final Clock _clock;

  Future<Order> call({
    required String actorId,
    required String teamId,
    required String concept,
    required Money total,
    required DateTime spentAt,
    required bool creditorIncluded,
    required List<SplitEntry> entries,
    String? note,
  }) async {
    final changes = CreateOrder(_newId)(
      creditorId: actorId,
      teamId: teamId,
      memberIds: await _directory.memberIds(teamId),
      creditorHasPayoutMethod:
          await _directory.payoutOf(teamId, actorId) != null,
      concept: concept,
      note: note,
      total: total,
      spentAt: spentAt,
      creditorIncluded: creditorIncluded,
      entries: entries,
      now: _clock(),
    );
    await _repo.apply(changes, actorId: actorId, teamId: teamId);
    return changes.order!;
  }
}
