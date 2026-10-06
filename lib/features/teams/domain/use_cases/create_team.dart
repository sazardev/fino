import '../../../../core/ids/id_generator.dart';
import '../entities/invite_codes.dart';
import '../entities/team.dart';
import '../entities/team_change.dart';
import '../entities/team_member.dart';
import '../enums/team_change_kind.dart';
import '../enums/team_role.dart';
import '../failures/team_failure.dart';
import '../failures/team_failure_reason.dart';

/// Crea un equipo; quien lo crea queda como admin (SPEC E1).
class CreateTeam {
  const new(this._newId, this._newCode);

  static const maxNameLength = 50;

  final IdGenerator _newId;
  final InviteCodeGenerator _newCode;

  TeamChange call({
    required String creatorId,
    required String name,
    required String creatorName,
    required DateTime now,
    String? creatorPhotoUrl,
  }) {
    final cleanName = name.trim();
    if (cleanName.isEmpty || cleanName.length > maxNameLength) {
      throw const TeamFailure(TeamFailureReason.invalidName);
    }
    final team = Team(
      id: _newId(),
      name: cleanName,
      inviteCode: _newCode(),
      createdAt: now,
    );
    return TeamChange(
      kind: TeamChangeKind.created,
      teamId: team.id,
      team: team,
      members: [
        TeamMember(
          teamId: team.id,
          userId: creatorId,
          role: TeamRole.admin,
          joinedAt: now,
          displayName: creatorName,
          photoUrl: creatorPhotoUrl,
        ),
      ],
    );
  }
}
