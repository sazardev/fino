import '../../../../core/time/clock.dart';
import '../entities/invite_codes.dart';
import '../entities/team.dart';
import '../failures/team_failure.dart';
import '../failures/team_failure_reason.dart';
import '../invite_lookup.dart';
import '../team_store.dart';
import '../use_cases/join_team.dart';

/// Entra a un equipo con su código (SPEC E2). Necesita conexión: el código
/// solo se puede verificar en el servidor.
class JoinTeamCommand {
  const new(this._store, this._invites, this._clock);

  final TeamStore _store;
  final InviteLookup _invites;
  final Clock _clock;

  Future<Team> call({
    required String userId,
    required String displayName,
    required String code,
    String? photoUrl,
  }) async {
    final normalized = InviteCodes.normalize(code);
    final invite = await _invites.find(normalized);
    if (invite == null) {
      throw const TeamFailure(TeamFailureReason.invalidInviteCode);
    }
    final now = _clock();
    final team = Team(
      id: invite.teamId,
      name: invite.teamName,
      inviteCode: normalized,
      createdAt: now,
    );
    final change = const JoinTeam()(
      team: team,
      enteredCode: normalized,
      roster: await _store.rosterOf(team.id),
      userId: userId,
      displayName: displayName,
      photoUrl: photoUrl,
      now: now,
    );
    await _store.apply(change, actorId: userId);
    return team;
  }
}
