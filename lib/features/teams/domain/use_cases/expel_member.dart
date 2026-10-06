import '../entities/live_debts.dart';
import '../entities/team_change.dart';
import '../entities/team_roster.dart';
import '../enums/team_change_kind.dart';
import '../failures/team_failure.dart';
import '../failures/team_failure_reason.dart';

/// El admin expulsa a un miembro sin deudas vivas (SPEC §4.2).
class ExpelMember {
  const new();

  TeamChange call({
    required String actorId,
    required String targetUserId,
    required TeamRoster roster,
    required LiveDebts targetLiveDebts,
  }) {
    if (!roster.isAdmin(actorId)) {
      throw const TeamFailure(TeamFailureReason.notAdmin);
    }
    if (actorId == targetUserId) {
      throw const TeamFailure(TeamFailureReason.cannotTargetSelf);
    }
    if (!roster.isMember(targetUserId)) {
      throw const TeamFailure(TeamFailureReason.targetNotMember);
    }
    if (targetLiveDebts.hasAny) {
      throw TeamFailure(
        TeamFailureReason.hasLiveDebts,
        blocking: targetLiveDebts,
      );
    }
    return TeamChange(
      kind: TeamChangeKind.membersRemoved,
      teamId: roster.memberOf(targetUserId)!.teamId,
      removedUserIds: [targetUserId],
    );
  }
}
