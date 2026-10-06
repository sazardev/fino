import '../team_store.dart';
import '../use_cases/refresh_member_profile.dart';

/// Refresca nombre y foto de Google en un equipo (SPEC U2).
class RefreshMemberProfileCommand {
  const new(this._store);

  final TeamStore _store;

  Future<void> call({
    required String userId,
    required String teamId,
    required String displayName,
    String? photoUrl,
  }) async {
    final change = const RefreshMemberProfile()(
      userId: userId,
      roster: await _store.rosterOf(teamId),
      displayName: displayName,
      photoUrl: photoUrl,
    );
    await _store.apply(change, actorId: userId);
  }
}
