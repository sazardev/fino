import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/enums/team_role.dart';
import '../tables/payout_methods.dart';
import '../tables/team_members.dart';
import '../tables/teams.dart';

part 'teams_dao.g.dart';

/// Consultas locales de equipos, miembros y métodos de cobro.
@DriftAccessor(tables: [Teams, TeamMembers, PayoutMethods])
class TeamsDao extends DatabaseAccessor<AppDatabase> with _$TeamsDaoMixin {
  new(super.attachedDatabase);

  Future<void> upsertTeam(TeamsCompanion team) =>
      into(teams).insertOnConflictUpdate(team);

  /// Equipos donde [userId] es miembro, según lo guardado.
  Future<Set<String>> teamIdsOf(String userId) async => {
    for (final row in await (select(
      teamMembers,
    )..where((m) => m.userId.equals(userId))).get())
      row.teamId,
  };

  Future<void> setInviteCode(String teamId, String code) =>
      (update(teams)..where((t) => t.id.equals(teamId))).write(
        TeamsCompanion(inviteCode: Value(code)),
      );

  Future<void> setAdmin(String teamId, String adminId) =>
      (update(teams)..where((t) => t.id.equals(teamId))).write(
        TeamsCompanion(adminId: Value(adminId)),
      );

  Future<void> removePayoutMethod(String teamId, String userId) => (delete(
    payoutMethods,
  )..where((p) => p.teamId.equals(teamId) & p.userId.equals(userId))).go();

  Stream<TeamRow?> watchTeam(String teamId) =>
      (select(teams)..where((t) => t.id.equals(teamId))).watchSingleOrNull();

  Future<TeamRow?> findTeam(String teamId) =>
      (select(teams)..where((t) => t.id.equals(teamId))).getSingleOrNull();

  /// Los equipos de [userId], por nombre.
  Stream<List<TeamRow>> watchTeamsOf(String userId) {
    final query =
        select(teams).join([
            innerJoin(teamMembers, teamMembers.teamId.equalsExp(teams.id)),
          ])
          ..where(teamMembers.userId.equals(userId))
          ..orderBy([OrderingTerm.asc(teams.name)]);
    return query.map((row) => row.readTable(teams)).watch();
  }

  /// Cada equipo de [userId], por nombre, con el rol que tiene ahí y cuántos
  /// miembros hay.
  Stream<List<(TeamRow, TeamRole, int)>> watchMembershipsOf(String userId) {
    final mine = alias(teamMembers, 'mine');
    final size = teamMembers.userId.count();
    final query =
        select(teams).join([
            innerJoin(
              mine,
              mine.teamId.equalsExp(teams.id) & mine.userId.equals(userId),
            ),
            innerJoin(teamMembers, teamMembers.teamId.equalsExp(teams.id)),
          ])
          ..addColumns([size])
          ..groupBy([teams.id, mine.userId])
          ..orderBy([OrderingTerm.asc(teams.name)]);
    return query
        .map((r) => (r.readTable(teams), r.readTable(mine).role, r.read(size)!))
        .watch();
  }

  /// Borra el equipo y lo suyo en estas tablas (no toca pedidos ni deudas).
  Future<void> deleteTeam(String teamId) => transaction(() async {
    await (delete(payoutMethods)..where((p) => p.teamId.equals(teamId))).go();
    await (delete(teamMembers)..where((m) => m.teamId.equals(teamId))).go();
    await (delete(teams)..where((t) => t.id.equals(teamId))).go();
  });

  Future<void> upsertMember(TeamMembersCompanion member) =>
      into(teamMembers).insertOnConflictUpdate(member);

  Future<void> removeMember(String teamId, String userId) => (delete(
    teamMembers,
  )..where((m) => m.teamId.equals(teamId) & m.userId.equals(userId))).go();

  Future<List<TeamMemberRow>> membersOf(String teamId) =>
      (select(teamMembers)..where((m) => m.teamId.equals(teamId))).get();

  Stream<List<TeamMemberRow>> watchMembers(String teamId) =>
      (select(teamMembers)
            ..where((m) => m.teamId.equals(teamId))
            ..orderBy([
              (m) => OrderingTerm.asc(m.joinedAt),
              (m) => OrderingTerm.asc(m.userId),
            ]))
          .watch();

  Future<void> upsertPayoutMethod(PayoutMethodsCompanion method) =>
      into(payoutMethods).insertOnConflictUpdate(method);

  Future<PayoutMethodRow?> findPayoutMethod(String teamId, String userId) =>
      (select(payoutMethods)
            ..where((p) => p.teamId.equals(teamId) & p.userId.equals(userId)))
          .getSingleOrNull();

  Stream<PayoutMethodRow?> watchPayoutMethod(String teamId, String userId) =>
      (select(payoutMethods)
            ..where((p) => p.teamId.equals(teamId) & p.userId.equals(userId)))
          .watchSingleOrNull();
}
