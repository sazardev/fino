import 'package:fino/core/money/money.dart';
import 'package:fino/core/notifications/inbox_write_planner.dart';
import 'package:fino/features/notices/data/remote/notice_write_planner.dart';
import 'package:fino/features/notices/domain/entities/notice_content.dart';
import 'package:fino/features/notices/domain/use_cases/send_notice.dart';
import 'package:fino/features/teams/data/remote/team_lifecycle_write_planner.dart';
import 'package:fino/features/teams/data/remote/team_membership_write_planner.dart';
import 'package:fino/features/teams/domain/entities/card_payout.dart';
import 'package:fino/features/teams/domain/entities/clabe_payout.dart';
import 'package:fino/features/teams/domain/entities/live_debts.dart';
import 'package:fino/features/teams/domain/entities/team.dart';
import 'package:fino/features/teams/domain/entities/team_member.dart';
import 'package:fino/features/teams/domain/entities/team_roster.dart';
import 'package:fino/features/teams/domain/enums/team_role.dart';
import 'package:fino/features/teams/domain/use_cases/create_team.dart';
import 'package:fino/features/teams/domain/use_cases/delete_team.dart';
import 'package:fino/features/teams/domain/use_cases/expel_member.dart';
import 'package:fino/features/teams/domain/use_cases/join_team.dart';
import 'package:fino/features/teams/domain/use_cases/leave_team.dart';
import 'package:fino/features/teams/domain/use_cases/regenerate_invite_code.dart';
import 'package:fino/features/teams/domain/use_cases/set_payout_method.dart';
import 'package:fino/features/teams/domain/use_cases/transfer_admin.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/contract_harness.dart';
import 'support/firestore_rest.dart';
import 'support/rules_emulator.dart';
import 'support/rules_matchers.dart';
import 'support/rules_world.dart';

/// Las acciones de equipos y avisos, planeadas como lo hará la app, deben
/// pasar las reglas reales de Firestore.
void main() {
  if (skipWithoutRulesEmulator()) return;

  late FirestoreRest db;
  late RulesWorld w;
  late ContractHarness h;
  final now = DateTime.utc(2026, 10, 6, 12);
  const lifecycle = TeamLifecycleWritePlanner();
  const membership = TeamMembershipWritePlanner();

  setUpAll(() => db = FirestoreRest.fromEnvironment());
  setUp(() async {
    w = await RulesWorld.seed(db);
    h = ContractHarness(w);
  });

  TeamMember member(String id, [TeamRole role = TeamRole.member]) => TeamMember(
    teamId: w.teamId,
    userId: id,
    role: role,
    joinedAt: now,
    displayName: id,
  );

  TeamRoster roster() => TeamRoster([
    member('omar', TeamRole.admin),
    member('ana'),
    member('beto'),
    member('cris'),
  ]);

  Team team() => Team(
    id: w.teamId,
    name: 'Oficina',
    inviteCode: w.inviteCode,
    createdAt: now,
  );

  group('teams', () {
    test('creating a team: team, admin member and invite', () async {
      final change = CreateTeam(h.newId, () => 'ZOE${w.id}'.substring(0, 8))(
        creatorId: 'zoe',
        name: 'Nuevo',
        creatorName: 'Zoe',
        now: now,
      );

      expect(await h.push('zoe', lifecycle.planCreate(change)), isAllowed);
    });

    test('joining with the invite code', () async {
      final change = const JoinTeam()(
        team: team(),
        enteredCode: w.inviteCode,
        roster: roster(),
        userId: 'zoe',
        displayName: 'Zoe',
        photoUrl: 'http://x/z.png',
        now: now,
      );

      expect(
        await h.push(
          'zoe',
          membership.planJoin(change, inviteCode: w.inviteCode),
        ),
        isAllowed,
      );
      expect(await w.read('zoe', 'teams/${w.teamId}'), isAllowed);
    });

    test('setting the payout method (CLABE and card)', () async {
      for (final method in [
        ClabePayout.parse('012180000112345671', bankName: 'BBVA'),
        CardPayout.parse('4152313312345678', bankName: 'BBVA'),
      ]) {
        final change = const SetPayoutMethod()(
          userId: 'ana',
          roster: roster(),
          method: method,
        );

        expect(
          await h.push('ana', membership.planPayoutMethod(change)),
          isAllowed,
        );
      }
    });

    test('the admin regenerates the invite code', () async {
      final change = RegenerateInviteCode(() => 'N${w.id}')(
        actorId: 'omar',
        team: team(),
        roster: roster(),
      );

      expect(
        await h.push(
          'omar',
          lifecycle.planRegenerateCode(change, previousCode: w.inviteCode),
        ),
        isAllowed,
      );
    });

    test('transferring the admin role', () async {
      final change = const TransferAdmin()(
        actorId: 'omar',
        targetUserId: 'ana',
        roster: roster(),
      );

      expect(
        await h.push('omar', membership.planTransferAdmin(change)),
        isAllowed,
      );
    });

    test('a member leaves; the admin expels another', () async {
      final leave = const LeaveTeam()(
        userId: 'ana',
        roster: roster(),
        liveDebts: LiveDebts.none,
      );
      expect(
        await h.push(
          'ana',
          membership.planRemoveMembers(leave, teamId: w.teamId),
        ),
        isAllowed,
      );

      final expel = const ExpelMember()(
        actorId: 'omar',
        targetUserId: 'beto',
        roster: roster(),
        targetLiveDebts: LiveDebts.none,
      );
      expect(
        await h.push(
          'omar',
          membership.planRemoveMembers(expel, teamId: w.teamId),
        ),
        isAllowed,
      );
    });

    test('refreshing the Google profile', () async {
      final updated = member('ana')
          .copyWith(displayName: 'Ana G', photoUrl: null);

      expect(await h.push('ana', membership.planProfile(updated)), isAllowed);
    });

    test('deleting the team', () async {
      final change = const DeleteTeam()(
        actorId: 'omar',
        team: team(),
        roster: roster(),
        teamLiveDebts: LiveDebts.none,
      );

      expect(await h.push('omar', lifecycle.planDelete(change)), isAllowed);
    });
  });

  group('notices', () {
    test('a notice is logged and lands in each recipient inbox', () async {
      final result = SendNotice(h.newId)(
        senderId: 'omar',
        teamId: w.teamId,
        memberIds: roster().memberIds,
        recipientIds: ['ana', 'beto'],
        content: NoticeContent.custom('ya paguen'),
        owedByRecipient: {'ana': const Money(10000)},
        lastSentAt: const {},
        now: now,
      );

      final writes = [
        ...const NoticeWritePlanner().plan(result),
        ...InboxWritePlanner(h.newId).plan(result.notifications),
      ];

      expect(await h.push('omar', writes), isAllowed);
    });
  });
}
