import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:fino/core/database/app_database.dart';
import 'package:fino/features/teams/data/local_teams_repository.dart';
import 'package:fino/features/teams/domain/enums/team_role.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late LocalTeamsRepository repository;
  final at = DateTime.utc(2026, 10, 6, 12);

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = LocalTeamsRepository(db.teamsDao);
  });
  tearDown(() => db.close());

  Future<void> addTeam(
    String id,
    String name,
    Map<String, TeamRole> users,
  ) async {
    await db.teamsDao.upsertTeam(
      TeamsCompanion.insert(
        id: id,
        name: name,
        adminId: users.entries.firstWhere((e) => e.value == TeamRole.admin).key,
        inviteCode: 'ABCD2345',
        createdAt: at,
      ),
    );
    for (final MapEntry(key: user, value: role) in users.entries) {
      await db.teamsDao.upsertMember(
        TeamMembersCompanion.insert(
          teamId: id,
          userId: user,
          role: role,
          joinedAt: at,
          displayName: user,
          photoUrl: const Value(null),
        ),
      );
    }
  }

  test('lists my teams by name with my role and their size', () async {
    await addTeam('t2', 'Viernes', {
      'ana': TeamRole.admin,
      'omar': TeamRole.member,
      'beto': TeamRole.member,
    });
    await addTeam('t1', 'Oficina', {'omar': TeamRole.admin});
    await addTeam('t3', 'Ajeno', {
      'ana': TeamRole.admin,
      'beto': TeamRole.member,
    });

    final teams = await repository.watchTeamsOf('omar').first;

    expect(teams.map((t) => t.team.name), ['Oficina', 'Viernes']);
    expect(teams.map((t) => t.role), [TeamRole.admin, TeamRole.member]);
    expect(teams.map((t) => t.memberCount), [1, 3]);
  });

  test('is empty for someone with no teams', () async {
    await addTeam('t1', 'Oficina', {'ana': TeamRole.admin});

    expect(await repository.watchTeamsOf('omar').first, isEmpty);
  });

  test('follows the database as people join', () async {
    await addTeam('t1', 'Oficina', {'omar': TeamRole.admin});
    final counts = repository
        .watchTeamsOf('omar')
        .map((teams) => teams.single.memberCount);
    final seen = expectLater(counts, emitsInOrder([1, 2]));

    await pumpEventQueue();
    await db.teamsDao.upsertMember(
      TeamMembersCompanion.insert(
        teamId: 't1',
        userId: 'ana',
        role: TeamRole.member,
        joinedAt: at,
        displayName: 'Ana',
      ),
    );
    await seen;
  });
}
