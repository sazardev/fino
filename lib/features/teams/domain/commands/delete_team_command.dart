import '../failures/team_failure.dart';
import '../failures/team_failure_reason.dart';
import '../live_debts_directory.dart';
import '../team_store.dart';
import '../use_cases/delete_team.dart';

/// El admin elimina el equipo si no queda ninguna deuda viva (SPEC §4.2).
class DeleteTeamCommand {
  const new(this._store, this._debts);

  final TeamStore _store;
  final LiveDebtsDirectory _debts;

  Future<void> call({required String actorId, required String teamId}) async {
    final team = await _store.findTeam(teamId);
    if (team == null) {
      throw const TeamFailure(TeamFailureReason.notMember);
    }
    final change = const DeleteTeam()(
      actorId: actorId,
      team: team,
      roster: await _store.rosterOf(teamId),
      teamLiveDebts: await _debts.ofTeam(teamId),
    );
    await _store.apply(change, actorId: actorId);
  }
}
