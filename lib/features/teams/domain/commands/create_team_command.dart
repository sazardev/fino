import '../../../../core/ids/id_generator.dart';
import '../../../../core/time/clock.dart';
import '../entities/invite_codes.dart';
import '../entities/team.dart';
import '../team_store.dart';
import '../use_cases/create_team.dart';

/// Crea un equipo; quien lo crea queda como admin (SPEC E1).
class CreateTeamCommand {
  const new(this._store, this._newId, this._newCode, this._clock);

  final TeamStore _store;
  final IdGenerator _newId;
  final InviteCodeGenerator _newCode;
  final Clock _clock;

  Future<Team> call({
    required String userId,
    required String name,
    required String displayName,
    String? photoUrl,
  }) async {
    final change = CreateTeam(_newId, _newCode)(
      creatorId: userId,
      name: name,
      creatorName: displayName,
      creatorPhotoUrl: photoUrl,
      now: _clock(),
    );
    await _store.apply(change, actorId: userId);
    return change.team!;
  }
}
