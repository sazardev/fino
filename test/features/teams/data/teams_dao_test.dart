import 'package:drift/native.dart';
import 'package:fino/core/database/app_database.dart';
import 'package:fino/features/teams/data/mappers/payout_method_mapper.dart';
import 'package:fino/features/teams/data/mappers/team_mapper.dart';
import 'package:fino/features/teams/data/mappers/team_member_mapper.dart';
import 'package:fino/features/teams/domain/entities/card_payout.dart';
import 'package:fino/features/teams/domain/entities/clabe_payout.dart';
import 'package:fino/features/teams/domain/entities/team.dart';
import 'package:fino/features/teams/domain/entities/team_member.dart';
import 'package:fino/features/teams/domain/enums/team_role.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  final at = DateTime.utc(2026, 10, 6, 12);

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  Team team(String id, String name) =>
      Team(id: id, name: name, inviteCode: 'ABCD2345', createdAt: at);

  TeamMember member(String teamId, String userId, {TeamRole? role}) =>
      TeamMember(
        teamId: teamId,
        userId: userId,
        role: role ?? TeamRole.member,
        joinedAt: at,
        displayName: userId.toUpperCase(),
        photoUrl: userId == 'ana' ? 'http://x/ana.png' : null,
      );

  Future<void> seedTeam(String id, String name, List<String> users) async {
    await db.teamsDao.upsertTeam(
      TeamMapper.toCompanion(team(id, name), adminId: users.first),
    );
    for (final user in users) {
      await db.teamsDao.upsertMember(
        TeamMemberMapper.toCompanion(member(id, user)),
      );
    }
  }

  test('a team survives the round trip to the database', () async {
    await seedTeam('t1', 'Oficina', ['omar']);

    final row = await db.teamsDao.findTeam('t1');

    expect(TeamMapper.toDomain(row!), team('t1', 'Oficina'));
    expect(row.adminId, 'omar');
    expect(await db.teamsDao.findTeam('nope'), isNull);
  });

  test('a user sees only their teams, by name', () async {
    await seedTeam('t1', 'Zeta', ['omar', 'ana']);
    await seedTeam('t2', 'Alfa', ['omar']);
    await seedTeam('t3', 'Otro', ['beto']);

    final mine = await db.teamsDao.watchTeamsOf('omar').first;
    final anas = await db.teamsDao.watchTeamsOf('ana').first;

    expect(mine.map((t) => t.name), ['Alfa', 'Zeta']);
    expect(anas.map((t) => t.name), ['Zeta']);
  });

  test('members keep their profile and role', () async {
    await seedTeam('t1', 'Oficina', ['omar']);
    final admin = member('t1', 'ana', role: TeamRole.admin);
    await db.teamsDao.upsertMember(TeamMemberMapper.toCompanion(admin));

    final rows = await db.teamsDao.membersOf('t1');
    final mapped = rows.map(TeamMemberMapper.toDomain).toList();

    expect(mapped, contains(admin));
    expect(mapped.firstWhere((m) => m.userId == 'ana').photoUrl, isNotNull);
    expect((await db.teamsDao.watchMembers('t1').first).map((m) => m.userId), [
      'ana',
      'omar',
    ]);
  });

  test('removing a member only removes them', () async {
    await seedTeam('t1', 'Oficina', ['omar', 'ana']);

    await db.teamsDao.removeMember('t1', 'ana');

    expect((await db.teamsDao.membersOf('t1')).single.userId, 'omar');
  });

  group('payout methods (M4)', () {
    test('CLABE and card round-trip through the database', () async {
      final clabe = ClabePayout.parse(
        '012180000112345671',
        bankName: 'BBVA',
        holderName: 'Omar',
      );
      final card = CardPayout.parse('4152313312345678', bankName: 'BBVA');

      await db.teamsDao.upsertPayoutMethod(
        PayoutMethodMapper.toCompanion(clabe, teamId: 't1', userId: 'omar'),
      );
      await db.teamsDao.upsertPayoutMethod(
        PayoutMethodMapper.toCompanion(card, teamId: 't1', userId: 'ana'),
      );

      expect(
        PayoutMethodMapper.toDomain(
          (await db.teamsDao.findPayoutMethod('t1', 'omar'))!,
        ),
        clabe,
      );
      expect(
        PayoutMethodMapper.toDomain(
          (await db.teamsDao.watchPayoutMethod('t1', 'ana').first)!,
        ),
        card,
      );
      expect(await db.teamsDao.findPayoutMethod('t1', 'beto'), isNull);
    });

    test('replacing a method overwrites it', () async {
      final first = ClabePayout.parse('012180000112345671');
      final second = CardPayout.parse('4152313312345678', bankName: 'BBVA');
      for (final method in [first, second]) {
        await db.teamsDao.upsertPayoutMethod(
          PayoutMethodMapper.toCompanion(method, teamId: 't1', userId: 'omar'),
        );
      }

      final row = await db.teamsDao.findPayoutMethod('t1', 'omar');

      expect(PayoutMethodMapper.toDomain(row!), second);
    });
  });

  test('deleting a team removes its members and payout methods only', () async {
    await seedTeam('t1', 'Oficina', ['omar']);
    await seedTeam('t2', 'Otro', ['omar']);
    await db.teamsDao.upsertPayoutMethod(
      PayoutMethodMapper.toCompanion(
        ClabePayout.parse('012180000112345671'),
        teamId: 't1',
        userId: 'omar',
      ),
    );

    await db.teamsDao.deleteTeam('t1');

    expect(await db.teamsDao.findTeam('t1'), isNull);
    expect(await db.teamsDao.membersOf('t1'), isEmpty);
    expect(await db.teamsDao.findPayoutMethod('t1', 'omar'), isNull);
    expect(await db.teamsDao.findTeam('t2'), isNotNull);
  });
}
