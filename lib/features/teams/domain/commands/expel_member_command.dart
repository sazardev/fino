import '../live_debts_directory.dart';
import '../team_store.dart';
import '../use_cases/expel_member.dart';

/// El admin expulsa a un miembro sin deudas vivas (SPEC §4.2).
class ExpelMemberCommand {
  const new(this._store, this._debts);

  final TeamStore _store;
  final LiveDebtsDirectory _debts;

  Future<void> call({
    required String actorId,
    required String teamId,
    required String targetUserId,
  }) async {
    final change = const ExpelMember()(
      actorId: actorId,
      targetUserId: targetUserId,
      roster: await _store.rosterOf(teamId),
      targetLiveDebts: await _debts.ofUser(targetUserId, teamId),
    );
    await _store.apply(change, actorId: actorId);
  }
}
