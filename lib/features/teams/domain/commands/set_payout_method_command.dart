import '../entities/payout_method.dart';
import '../team_store.dart';
import '../use_cases/set_payout_method.dart';

/// Un miembro configura o reemplaza su método de cobro (SPEC M1).
class SetPayoutMethodCommand {
  const new(this._store);

  final TeamStore _store;

  Future<void> call({
    required String userId,
    required String teamId,
    required PayoutMethod method,
  }) async {
    final change = const SetPayoutMethod()(
      userId: userId,
      roster: await _store.rosterOf(teamId),
      method: method,
    );
    await _store.apply(change, actorId: userId);
  }
}
