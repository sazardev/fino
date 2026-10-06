import 'package:drift/native.dart';
import 'package:fino/core/database/app_database.dart';
import 'package:fino/core/database/app_database_provider.dart';
import 'package:fino/features/teams/data/local_teams_repository.dart';
import 'package:fino/features/teams/domain/enums/team_role.dart';
import 'package:fino/features/teams/presentation/providers/teams_repository_provider.dart';
import 'package:fino/features/teams/presentation/providers/user_teams_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late ProviderContainer container;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
    addTearDown(container.dispose);
    addTearDown(db.close);
  });

  test('teams are read from the local database', () {
    expect(
      container.read(teamsRepositoryProvider),
      isA<LocalTeamsRepository>(),
    );
  });

  test("a person's teams come through the provider", () async {
    await db.teamsDao.upsertTeam(
      TeamsCompanion.insert(
        id: 't1',
        name: 'Oficina',
        adminId: 'omar',
        inviteCode: 'ABCD2345',
        createdAt: DateTime.utc(2026),
      ),
    );
    await db.teamsDao.upsertMember(
      TeamMembersCompanion.insert(
        teamId: 't1',
        userId: 'omar',
        role: TeamRole.admin,
        joinedAt: DateTime.utc(2026),
        displayName: 'Omar',
      ),
    );

    final provider = userTeamsProvider('omar');
    container.listen(provider, (_, _) {});
    final teams = await container.read(provider.future);

    expect(teams.single.team.name, 'Oficina');
    expect(teams.single.role, TeamRole.admin);
  });
}
