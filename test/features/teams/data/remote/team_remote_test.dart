import 'package:fino/core/database/outbox_operation.dart';
import 'package:fino/core/sync/remote_array_op.dart';
import 'package:fino/core/sync/remote_marker.dart';
import 'package:fino/features/teams/data/remote/payout_method_remote_mapper.dart';
import 'package:fino/features/teams/data/remote/team_lifecycle_write_planner.dart';
import 'package:fino/features/teams/data/remote/team_member_remote_mapper.dart';
import 'package:fino/features/teams/data/remote/team_membership_write_planner.dart';
import 'package:fino/features/teams/data/remote/team_remote_mapper.dart';
import 'package:fino/features/teams/domain/entities/card_payout.dart';
import 'package:fino/features/teams/domain/entities/clabe_payout.dart';
import 'package:fino/features/teams/domain/entities/team.dart';
import 'package:fino/features/teams/domain/entities/team_change.dart';
import 'package:fino/features/teams/domain/entities/team_member.dart';
import 'package:fino/features/teams/domain/enums/team_change_kind.dart';
import 'package:fino/features/teams/domain/enums/team_role.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../support/resolve_markers.dart';
import '../../../orders/domain/support/order_fixtures.dart';

void main() {
  final team = Team(
    id: 't1',
    name: 'Oficina',
    inviteCode: 'ABCD2345',
    createdAt: t0,
  );
  TeamMember member(String id, {TeamRole? role, String? photo}) => TeamMember(
    teamId: 't1',
    userId: id,
    role: role ?? TeamRole.member,
    joinedAt: t0,
    displayName: id.toUpperCase(),
    photoUrl: photo,
  );
  const lifecycle = TeamLifecycleWritePlanner();
  const membership = TeamMembershipWritePlanner();

  group('documents', () {
    test('a team round-trips and exposes its admin and members', () {
      final fields = TeamRemoteMapper.toCreateFields(team, adminId: 'omar');

      expect(fields['memberIds'], ['omar']);
      expect(fields['createdAt'], RemoteMarker.serverTimestamp);
      final resolved = resolveMarkers(fields, t0);
      expect(TeamRemoteMapper.fromFields('t1', resolved), team);
      expect(TeamRemoteMapper.adminIdOf(resolved), 'omar');
      expect(TeamRemoteMapper.memberIdsOf(resolved), ['omar']);
    });

    test('a member round-trips; the invite code only travels on join', () {
      final ana = member('ana', photo: 'http://x/a.png');

      final plain = TeamMemberRemoteMapper.toCreateFields(ana);
      final joining = TeamMemberRemoteMapper.toCreateFields(
        ana,
        inviteCode: 'ABCD2345',
      );

      expect(plain, isNot(contains('inviteCode')));
      expect(joining['inviteCode'], 'ABCD2345');
      expect(
        TeamMemberRemoteMapper.fromFields('t1', resolveMarkers(plain, t0)),
        ana,
      );
      expect(TeamMemberRemoteMapper.toRoleFields(ana), {'role': 'member'});
      expect(
        TeamMemberRemoteMapper.toProfileFields(member('ana'))['photoUrl'],
        RemoteMarker.fieldDelete,
      );
    });

    test('payout methods round-trip', () {
      final clabe = ClabePayout.parse(
        '012180000112345671',
        bankName: 'BBVA',
        holderName: 'Omar',
      );
      final card = CardPayout.parse('4152313312345678', bankName: 'BBVA');

      expect(
        PayoutMethodRemoteMapper.fromFields(
          PayoutMethodRemoteMapper.toFields(clabe),
        ),
        clabe,
      );
      expect(
        PayoutMethodRemoteMapper.fromFields(
          PayoutMethodRemoteMapper.toFields(card),
        ),
        card,
      );
      expect(PayoutMethodRemoteMapper.toFields(card)['type'], 'card');
    });
  });

  group('team write planners', () {
    test('create: team, admin member and invite in one batch', () {
      final writes = lifecycle.planCreate(
        TeamChange(
          kind: TeamChangeKind.created,
          teamId: 't1',
          team: team,
          members: [member('omar', role: TeamRole.admin)],
        ),
      );

      expect(writes.map((w) => w.path), [
        'teams/t1',
        'teams/t1/members/omar',
        'invites/ABCD2345',
      ]);
      expect(writes[2].fields, {'teamId': 't1', 'teamName': 'Oficina'});
    });

    test('join: member with the code plus the memberIds union', () {
      final writes = membership.planJoin(
        TeamChange(
          kind: TeamChangeKind.joined,
          teamId: 't1',
          members: [member('zoe')],
        ),
        inviteCode: 'ABCD2345',
      );

      expect(writes.first.fields['inviteCode'], 'ABCD2345');
      final union = writes.last.fields['memberIds']! as RemoteArrayOp;
      expect(union.union, isTrue);
      expect(union.values, ['zoe']);
    });

    test('regenerate: new code, old invite deleted, new invite created', () {
      final writes = lifecycle.planRegenerateCode(
        TeamChange(
          kind: TeamChangeKind.inviteRegenerated,
          teamId: 't1',
          team: team.copyWith(inviteCode: 'NEWC0DE2'),
        ),
        previousCode: 'ABCD2345',
      );

      expect(writes[0].fields, {'inviteCode': 'NEWC0DE2'});
      expect(
        (writes[1].path, writes[1].operation),
        ('invites/ABCD2345', OutboxOperation.delete),
      );
      expect(writes[2].path, 'invites/NEWC0DE2');
    });

    test('transfer: the team points at the new admin and roles follow', () {
      final writes = membership.planTransferAdmin(
        TeamChange(
          kind: TeamChangeKind.adminTransferred,
          teamId: 't1',
          members: [
            member('ana', role: TeamRole.admin),
            member('omar'),
          ],
        ),
      );

      expect(writes.first.fields, {'adminId': 'ana'});
      expect(writes[1].fields, {'role': 'admin'});
      expect(writes[2].fields, {'role': 'member'});
    });

    test('leave or expel: delete members and shrink memberIds', () {
      final writes = membership.planRemoveMembers(
        const TeamChange(
          kind: TeamChangeKind.membersRemoved,
          teamId: 't1',
          removedUserIds: ['ana'],
        ),
        teamId: 't1',
      );

      expect(writes.first.operation, OutboxOperation.delete);
      expect(writes.first.path, 'teams/t1/members/ana');
      final removal = writes.last.fields['memberIds']! as RemoteArrayOp;
      expect(removal.union, isFalse);
      expect(removal.values, ['ana']);
    });

    test('delete also clears the member documents', () {
      final writes = lifecycle.planDelete(
        TeamChange(
          kind: TeamChangeKind.deleted,
          teamId: 't1',
          team: team,
          removedUserIds: const ['omar', 'ana'],
        ),
      );

      expect(writes.map((w) => w.path), [
        'teams/t1/members/omar',
        'teams/t1/members/ana',
        'teams/t1',
        'invites/ABCD2345',
      ]);
    });

    test('delete: the team and its invite', () {
      final writes = lifecycle.planDelete(
        TeamChange(kind: TeamChangeKind.deleted, teamId: 't1', team: team),
      );

      expect(writes.map((w) => w.path), ['teams/t1', 'invites/ABCD2345']);
      expect(
        writes.map((w) => w.operation),
        everyElement(OutboxOperation.delete),
      );
    });

    test(
      'payout method: an idempotent set under members/{uid}/payout/main',
      () {
        final change = TeamChange(
          kind: TeamChangeKind.payoutMethodSet,
          teamId: 't1',
          members: [
            member(
              'ana',
            ).copyWith(payoutMethod: ClabePayout.parse('012180000112345671')),
          ],
        );

        final write = membership.planPayoutMethod(change).single;

        expect(write.path, 'teams/t1/members/ana/payout/main');
        expect(write.operation, OutboxOperation.set);
        expect(write.fields['type'], 'clabe');
      },
    );

    test('profile refresh updates name and photo', () {
      final write = membership.planProfile(member('ana', photo: 'p')).single;

      expect(write.operation, OutboxOperation.update);
      expect(write.fields, {'displayName': 'ANA', 'photoUrl': 'p'});
    });
  });
}
