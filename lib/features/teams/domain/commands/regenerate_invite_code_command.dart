import '../entities/invite_codes.dart';
import '../failures/team_failure.dart';
import '../failures/team_failure_reason.dart';
import '../team_store.dart';
import '../use_cases/regenerate_invite_code.dart';

/// El admin cambia el código de invitación (SPEC E3).
class RegenerateInviteCodeCommand {
  const new(this._store, this._newCode);

  final TeamStore _store;
  final InviteCodeGenerator _newCode;

  /// Devuelve el código nuevo.
  Future<String> call({required String actorId, required String teamId}) async {
    final team = await _store.findTeam(teamId);
    if (team == null) {
      throw const TeamFailure(TeamFailureReason.notMember);
    }
    final change = RegenerateInviteCode(_newCode)(
      actorId: actorId,
      team: team,
      roster: await _store.rosterOf(teamId),
    );
    await _store.apply(change, actorId: actorId);
    return change.team!.inviteCode;
  }
}
