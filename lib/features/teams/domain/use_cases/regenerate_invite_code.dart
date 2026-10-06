import '../entities/invite_codes.dart';
import '../entities/team.dart';
import '../entities/team_change.dart';
import '../entities/team_roster.dart';
import '../enums/team_change_kind.dart';
import '../failures/team_failure.dart';
import '../failures/team_failure_reason.dart';

/// El admin cambia el código; el anterior deja de servir (SPEC E3).
class RegenerateInviteCode {
  const new(this._newCode);

  final InviteCodeGenerator _newCode;

  TeamChange call({
    required String actorId,
    required Team team,
    required TeamRoster roster,
  }) {
    if (!roster.isAdmin(actorId)) {
      throw const TeamFailure(TeamFailureReason.notAdmin);
    }
    var code = _newCode();
    while (code == team.inviteCode) {
      code = _newCode();
    }
    return TeamChange(
      kind: TeamChangeKind.inviteRegenerated,
      teamId: team.id,
      team: team.copyWith(inviteCode: code),
      previousInviteCode: team.inviteCode,
    );
  }
}
