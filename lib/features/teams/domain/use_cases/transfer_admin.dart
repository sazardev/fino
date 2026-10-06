import '../entities/team_change.dart';
import '../entities/team_roster.dart';
import '../enums/team_change_kind.dart';
import '../enums/team_role.dart';
import '../failures/team_failure.dart';
import '../failures/team_failure_reason.dart';

/// El admin pasa su rol a otro miembro (SPEC E6).
class TransferAdmin {
  const new();

  TeamChange call({
    required String actorId,
    required String targetUserId,
    required TeamRoster roster,
  }) {
    if (!roster.isAdmin(actorId)) {
      throw const TeamFailure(TeamFailureReason.notAdmin);
    }
    if (actorId == targetUserId) {
      throw const TeamFailure(TeamFailureReason.cannotTargetSelf);
    }
    final target = roster.memberOf(targetUserId);
    if (target == null) {
      throw const TeamFailure(TeamFailureReason.targetNotMember);
    }
    return TeamChange(
      kind: TeamChangeKind.adminTransferred,
      teamId: target.teamId,
      members: [
        target.copyWith(role: TeamRole.admin),
        roster.memberOf(actorId)!.copyWith(role: TeamRole.member),
      ],
    );
  }
}
