import '../entities/live_debts.dart';
import '../entities/team.dart';
import '../entities/team_change.dart';
import '../entities/team_roster.dart';
import '../enums/team_change_kind.dart';
import '../failures/team_failure.dart';
import '../failures/team_failure_reason.dart';

/// El admin elimina el equipo si no queda ninguna deuda viva (SPEC §4.2).
class DeleteTeam {
  const new();

  TeamChange call({
    required String actorId,
    required Team team,
    required TeamRoster roster,
    required LiveDebts teamLiveDebts,
  }) {
    if (!roster.isAdmin(actorId)) {
      throw const TeamFailure(TeamFailureReason.notAdmin);
    }
    if (teamLiveDebts.hasAny) {
      throw TeamFailure(
        TeamFailureReason.hasLiveDebts,
        blocking: teamLiveDebts,
      );
    }
    return TeamChange(
      kind: TeamChangeKind.deleted,
      teamId: team.id,
      team: team,
      removedUserIds: [for (final member in roster.members) member.userId],
    );
  }
}
