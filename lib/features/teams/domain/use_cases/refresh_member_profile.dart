import '../entities/team_change.dart';
import '../entities/team_roster.dart';
import '../enums/team_change_kind.dart';
import '../failures/team_failure.dart';
import '../failures/team_failure_reason.dart';

/// Un miembro refresca su nombre y foto de Google (SPEC U2).
class RefreshMemberProfile {
  const new();

  static const maxNameLength = 80;

  /// Si nada cambió no hace nada.
  TeamChange call({
    required String userId,
    required TeamRoster roster,
    required String displayName,
    String? photoUrl,
  }) {
    final member = roster.memberOf(userId);
    if (member == null) {
      throw const TeamFailure(TeamFailureReason.notMember);
    }
    final name = displayName.trim();
    if (name.isEmpty || name.length > maxNameLength) {
      throw const TeamFailure(TeamFailureReason.invalidName);
    }
    if (member.displayName == name && member.photoUrl == photoUrl) {
      return TeamChange.empty;
    }
    return TeamChange(
      kind: TeamChangeKind.profileUpdated,
      teamId: member.teamId,
      members: [member.copyWith(displayName: name, photoUrl: photoUrl)],
    );
  }
}
