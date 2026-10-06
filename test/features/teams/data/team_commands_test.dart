import 'package:drift/drift.dart' show Value;
import 'package:fino/core/database/app_database.dart';
import 'package:fino/core/database/outbox_operation.dart';
import 'package:fino/core/money/money.dart';
import 'package:fino/features/orders/data/mappers/debt_mapper.dart';
import 'package:fino/features/orders/domain/entities/debt.dart';
import 'package:fino/features/orders/domain/enums/debt_status.dart';
import 'package:fino/features/teams/data/payout_method_type.dart';
import 'package:fino/features/teams/domain/entities/clabe_payout.dart';
import 'package:fino/features/teams/domain/entities/invite_info.dart';
import 'package:fino/features/teams/domain/enums/team_role.dart';
import 'package:fino/features/teams/domain/failures/team_failure_reason.dart';
import 'package:flutter_test/flutter_test.dart';

import '../domain/support/team_matchers.dart';
import 'support/teams_harness.dart';

void main() {
  late TeamsHarness h;

  setUp(() => h = TeamsHarness());
  tearDown(() => h.close());

  Future<String> createOficina() async {
    final team = await h.createTeam(
      userId: 'omar',
      name: 'Oficina',
      displayName: 'Omar',
      photoUrl: 'http://x/o.png',
    );
    return team.id;
  }

  Future<void> addMember(String teamId, String userId) =>
      h.db.teamsDao.upsertMember(
        TeamMembersCompanion.insert(
          teamId: teamId,
          userId: userId,
          role: TeamRole.member,
          joinedAt: h.now,
          displayName: userId,
        ),
      );

  Future<void> liveDebt(String teamId, String creditor, String debtor) =>
      h.db.debtsDao.upsertDebts([
        DebtMapper.toCompanion(
          Debt(
            id: 'd-$creditor-$debtor',
            orderId: 'o1',
            teamId: teamId,
            creditorId: creditor,
            debtorId: debtor,
            amount: const Money(100),
            status: DebtStatus.pending,
            createdAt: h.now,
            updatedAt: h.now,
          ),
        ),
      ]);

  group('creating and joining', () {
    test('creating saves the team, its admin and one batch', () async {
      final teamId = await createOficina();

      final team = await h.store.findTeam(teamId);
      final members = await h.store.watchMembers(teamId).first;
      expect(team!.name, 'Oficina');
      expect(members.single.role, TeamRole.admin);
      expect(members.single.photoUrl, 'http://x/o.png');
      expect((await h.batches()).single.map((w) => w.path), [
        'teams/$teamId',
        'teams/$teamId/members/omar',
        'invites/${team.inviteCode}',
      ]);
      expect((await h.db.teamsDao.findTeam(teamId))!.adminId, 'omar');
    });

    test('joining looks the code up and queues the member batch', () async {
      h.invites.invites['ABCD2345'] = const InviteInfo(
        teamId: 't9',
        teamName: 'Otro',
      );

      final team = await h.joinTeam(
        userId: 'zoe',
        displayName: 'Zoe',
        code: 'abcd-2345',
      );

      expect(team.id, 't9');
      expect((await h.store.rosterOf('t9')).isMember('zoe'), isTrue);
      final batch = (await h.batches()).single;
      expect(batch.first.fields['inviteCode'], 'ABCD2345');
      expect(batch.last.path, 'teams/t9');
    });

    test('an unknown code is refused and nothing is queued', () async {
      expect(
        () => h.joinTeam(userId: 'zoe', displayName: 'Zoe', code: 'NOPE0000'),
        throwsTeam(TeamFailureReason.invalidInviteCode),
      );
      expect(await h.batches(), isEmpty);
    });

    test('joining a team you already belong to changes nothing', () async {
      final teamId = await createOficina();
      final code = (await h.store.findTeam(teamId))!.inviteCode;
      h.invites.invites[code] = InviteInfo(teamId: teamId, teamName: 'Oficina');
      final before = (await h.batches()).length;

      await h.joinTeam(userId: 'omar', displayName: 'Omar', code: code);

      expect((await h.batches()).length, before);
    });
  });

  group('administration', () {
    test('regenerating swaps the invite code', () async {
      final teamId = await createOficina();
      final old = (await h.store.findTeam(teamId))!.inviteCode;

      final fresh = await h.regenerateCode(actorId: 'omar', teamId: teamId);

      expect(fresh, isNot(old));
      expect((await h.store.findTeam(teamId))!.inviteCode, fresh);
      expect((await h.batches()).last.map((w) => w.path), [
        'teams/$teamId',
        'invites/$old',
        'invites/$fresh',
      ]);
    });

    test('transferring moves the admin role', () async {
      final teamId = await createOficina();
      await addMember(teamId, 'ana');

      await h.transferAdmin(
        actorId: 'omar',
        teamId: teamId,
        targetUserId: 'ana',
      );

      expect((await h.db.teamsDao.findTeam(teamId))!.adminId, 'ana');
      final roles = {
        for (final m in await h.store.watchMembers(teamId).first)
          m.userId: m.role,
      };
      expect(roles, {'omar': TeamRole.member, 'ana': TeamRole.admin});
    });

    test('profile and payout method are saved and observable', () async {
      final teamId = await createOficina();
      final clabe = ClabePayout.parse('012180000112345671', bankName: 'BBVA');

      await h.refreshProfile(
        userId: 'omar',
        teamId: teamId,
        displayName: 'Omar G',
      );
      await h.setPayoutMethod(userId: 'omar', teamId: teamId, method: clabe);

      expect(await h.store.watchPayoutMethod(teamId, 'omar').first, clabe);
      final me = (await h.store.watchMembers(teamId).first).single;
      expect(me.displayName, 'Omar G');
      expect(me.photoUrl, isNull);
    });
  });

  group('leaving, expelling and deleting (SPEC 4.2)', () {
    test(
      'a member without live debts leaves: everything local is purged',
      () async {
        final teamId = await createOficina();
        await addMember(teamId, 'ana');
        await liveDebt(teamId, 'omar', 'beto');

        await h.leaveTeam(userId: 'ana', teamId: teamId);

        expect(await h.store.findTeam(teamId), isNull);
        expect(await h.db.debtsDao.liveCountOfTeam(teamId), 0);
      },
    );

    test('live debts block leaving', () async {
      final teamId = await createOficina();
      await addMember(teamId, 'ana');
      await liveDebt(teamId, 'omar', 'ana');

      expect(
        () => h.leaveTeam(userId: 'ana', teamId: teamId),
        throwsTeam(TeamFailureReason.hasLiveDebts),
      );
    });

    test('the admin expels a member but keeps the team', () async {
      final teamId = await createOficina();
      await addMember(teamId, 'ana');
      await h.db.teamsDao.upsertPayoutMethod(
        PayoutMethodsCompanion.insert(
          teamId: teamId,
          userId: 'ana',
          type: PayoutMethodType.clabe,
          number: '012180000112345671',
          bankName: const Value('BBVA'),
        ),
      );

      await h.expelMember(actorId: 'omar', teamId: teamId, targetUserId: 'ana');

      expect((await h.store.rosterOf(teamId)).isMember('ana'), isFalse);
      expect(await h.db.teamsDao.findPayoutMethod(teamId, 'ana'), isNull);
      expect(await h.store.findTeam(teamId), isNotNull);
    });

    test('deleting needs no live debts anywhere in the team', () async {
      final teamId = await createOficina();
      await liveDebt(teamId, 'omar', 'beto');
      await expectLater(
        h.deleteTeam(actorId: 'omar', teamId: teamId),
        throwsTeam(TeamFailureReason.hasLiveDebts),
      );

      await h.db.debtsDao.deleteTeamDebts(teamId);
      await h.deleteTeam(actorId: 'omar', teamId: teamId);

      expect(await h.store.findTeam(teamId), isNull);
      final last = (await h.batches()).last;
      expect(
        last.map((w) => w.operation),
        everyElement(OutboxOperation.delete),
      );
    });

    test('commands on an unknown team fail', () async {
      expect(
        () => h.deleteTeam(actorId: 'omar', teamId: 'ghost'),
        throwsTeam(TeamFailureReason.notMember),
      );
      expect(
        () => h.regenerateCode(actorId: 'omar', teamId: 'ghost'),
        throwsTeam(TeamFailureReason.notMember),
      );
    });
  });
}
