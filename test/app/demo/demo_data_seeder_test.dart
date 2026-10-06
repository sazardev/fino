import 'package:drift/native.dart';
import 'package:fino/app/demo/demo_data_seeder.dart';
import 'package:fino/core/database/app_database.dart';
import 'package:fino/features/teams/data/local_teams_repository.dart';
import 'package:fino/features/teams/domain/entities/clabe_payout.dart';
import 'package:fino/features/teams/domain/enums/team_role.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_auth_repository.dart';

void main() {
  late AppDatabase db;
  late DemoDataSeeder seeder;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    seeder = DemoDataSeeder(db.teamsDao);
  });
  tearDown(() => db.close());

  Future<List<(String, TeamRole, int)>> teamsOf(String uid) async {
    final teams = await LocalTeamsRepository(db.teamsDao)
        .watchTeamsOf(uid)
        .first;
    return [for (final t in teams) (t.team.name, t.role, t.memberCount)];
  }

  test('the person runs one team and belongs to another', () async {
    await seeder.seed(testUser);

    expect(await teamsOf(testUser.uid), [
      ('Comidas del viernes', TeamRole.member, 4),
      ('Oficina', TeamRole.admin, 5),
    ]);
  });

  test('the person appears under their own name', () async {
    await seeder.seed(testUser);

    final members = await db.teamsDao.membersOf('demo-team-oficina');

    expect(
      members.singleWhere((m) => m.userId == testUser.uid).displayName,
      testUser.displayName,
    );
  });

  test('seeding again changes nothing', () async {
    await seeder.seed(testUser);
    await seeder.seed(testUser);

    expect(await teamsOf(testUser.uid), hasLength(2));
    expect(await db.teamsDao.membersOf('demo-team-oficina'), hasLength(5));
  });

  test("the sample payout method passes the app's own CLABE rules", () async {
    await seeder.seed(testUser);

    final method = await db.teamsDao.findPayoutMethod(
      'demo-team-oficina',
      testUser.uid,
    );

    expect(ClabePayout.parse(method!.number).clabe, method.number);
  });
}
