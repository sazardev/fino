import '../live_debts_directory.dart';
import '../team_store.dart';
import '../use_cases/leave_team.dart';

/// Sale de un equipo si no quedan deudas vivas (SPEC §4.2).
class LeaveTeamCommand {
  const new(this._store, this._debts);

  final TeamStore _store;
  final LiveDebtsDirectory _debts;

  Future<void> call({required String userId, required String teamId}) async {
    final change = const LeaveTeam()(
      userId: userId,
      roster: await _store.rosterOf(teamId),
      liveDebts: await _debts.ofUser(userId, teamId),
    );
    await _store.apply(change, actorId: userId);
  }
}
