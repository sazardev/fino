import '../entities/live_debts.dart';
import '../entities/team_change.dart';
import '../entities/team_roster.dart';
import '../enums/team_change_kind.dart';
import '../failures/team_failure.dart';
import '../failures/team_failure_reason.dart';

/// Salir de un equipo (SPEC §4.2, E6).
class LeaveTeam {
  const new();

  /// El admin primero transfiere el rol (o elimina el equipo si está solo).
  /// Con deudas vivas, como deudor o como acreedor, no se puede salir.
  TeamChange call({
    required String userId,
    required TeamRoster roster,
    required LiveDebts liveDebts,
  }) {
    if (!roster.isMember(userId)) {
      throw const TeamFailure(TeamFailureReason.notMember);
    }
    if (roster.isAdmin(userId)) {
      throw TeamFailure(
        roster.size == 1
            ? TeamFailureReason.adminMustDeleteTeam
            : TeamFailureReason.adminMustTransfer,
      );
    }
    if (liveDebts.hasAny) {
      throw TeamFailure(TeamFailureReason.hasLiveDebts, blocking: liveDebts);
    }
    return TeamChange(
      kind: TeamChangeKind.membersRemoved,
      teamId: roster.memberOf(userId)!.teamId,
      removedUserIds: [userId],
    );
  }
}
