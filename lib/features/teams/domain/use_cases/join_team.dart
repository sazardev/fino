import '../../../../core/notifications/intent/notification_intent.dart';
import '../../../../core/notifications/intent/notification_kind.dart';
import '../../../../core/notifications/intent/notification_target.dart';
import '../entities/invite_codes.dart';
import '../entities/team.dart';
import '../entities/team_change.dart';
import '../entities/team_member.dart';
import '../entities/team_roster.dart';
import '../enums/team_change_kind.dart';
import '../enums/team_role.dart';
import '../failures/team_failure.dart';
import '../failures/team_failure_reason.dart';

/// Entrar a un equipo con su código de invitación (SPEC E2, E4).
class JoinTeam {
  const new();

  /// Si [userId] ya es miembro no cambia nada: solo se le lleva al equipo.
  TeamChange call({
    required Team team,
    required String enteredCode,
    required TeamRoster roster,
    required String userId,
    required String displayName,
    required DateTime now,
    String? photoUrl,
  }) {
    if (InviteCodes.normalize(enteredCode) !=
        InviteCodes.normalize(team.inviteCode)) {
      throw const TeamFailure(TeamFailureReason.invalidInviteCode);
    }
    if (roster.isMember(userId)) return TeamChange.empty;

    return TeamChange(
      kind: TeamChangeKind.joined,
      teamId: team.id,
      team: team,
      inviteCode: team.inviteCode,
      members: [
        TeamMember(
          teamId: team.id,
          userId: userId,
          role: TeamRole.member,
          joinedAt: now,
          displayName: displayName,
          photoUrl: photoUrl,
        ),
      ],
      notifications: [
        for (final admin in roster.admins)
          NotificationIntent(
            kind: NotificationKind.memberJoined,
            recipientId: admin.userId,
            actorId: userId,
            teamId: team.id,
            target: NotificationTarget.team(team.id),
          ),
      ],
    );
  }
}
