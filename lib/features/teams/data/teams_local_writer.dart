import '../../../core/database/app_database.dart';
import '../domain/entities/team_change.dart';
import '../domain/enums/team_change_kind.dart';
import '../domain/enums/team_role.dart';
import 'mappers/payout_method_mapper.dart';
import 'mappers/team_mapper.dart';
import 'mappers/team_member_mapper.dart';

/// Guarda en Drift lo que cambió una acción de equipos.
class TeamsLocalWriter {
  const new(this._db);

  final AppDatabase _db;

  /// [actorId] es quien ejecutó la acción: si es quien sale, se borra todo
  /// lo local del equipo.
  Future<void> write(TeamChange change, {required String actorId}) async {
    final teams = _db.teamsDao;
    switch (change.kind) {
      case TeamChangeKind.none:
        return;
      case TeamChangeKind.created:
        await teams.upsertTeam(
          TeamMapper.toCompanion(
            change.team!,
            adminId: change.members.single.userId,
          ),
        );
        await _upsertMembers(change);
      case TeamChangeKind.joined:
        await _keepTeamUntilSynced(change);
        await _upsertMembers(change);
      case TeamChangeKind.profileUpdated:
        await _upsertMembers(change);
      case TeamChangeKind.inviteRegenerated:
        await teams.setInviteCode(change.teamId, change.team!.inviteCode);
      case TeamChangeKind.adminTransferred:
        final admin = change.members.firstWhere(
          (m) => m.role == TeamRole.admin,
        );
        await teams.setAdmin(change.teamId, admin.userId);
        await _upsertMembers(change);
      case TeamChangeKind.membersRemoved:
        if (change.removedUserIds.contains(actorId)) {
          await _db.purgeTeamData(change.teamId);
          return;
        }
        for (final userId in change.removedUserIds) {
          await teams.removeMember(change.teamId, userId);
          await teams.removePayoutMethod(change.teamId, userId);
        }
      case TeamChangeKind.deleted:
        await _db.purgeTeamData(change.teamId);
      case TeamChangeKind.payoutMethodSet:
        final member = change.members.single;
        await teams.upsertPayoutMethod(
          PayoutMethodMapper.toCompanion(
            member.payoutMethod!,
            teamId: change.teamId,
            userId: member.userId,
          ),
        );
    }
  }

  /// Al entrar solo se conoce el equipo por su invitación: se guarda para
  /// verlo ya; la sincronización completa lo demás (admin, miembros).
  Future<void> _keepTeamUntilSynced(TeamChange change) async {
    final team = change.team;
    if (team == null || await _db.teamsDao.findTeam(team.id) != null) return;
    await _db.teamsDao.upsertTeam(TeamMapper.toCompanion(team, adminId: ''));
  }

  Future<void> _upsertMembers(TeamChange change) async {
    for (final member in change.members) {
      await _db.teamsDao.upsertMember(TeamMemberMapper.toCompanion(member));
    }
  }
}
