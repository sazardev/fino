import 'package:fino/core/notifications/intent/notification_kind.dart';
import 'package:fino/core/notifications/intent/notification_target.dart';
import 'package:fino/features/teams/domain/entities/team_change.dart';
import 'package:fino/features/teams/domain/enums/team_change_kind.dart';
import 'package:fino/features/teams/domain/enums/team_role.dart';
import 'package:fino/features/teams/domain/failures/team_failure_reason.dart';
import 'package:fino/features/teams/domain/use_cases/create_team.dart';
import 'package:fino/features/teams/domain/use_cases/join_team.dart';
import 'package:fino/features/teams/domain/use_cases/regenerate_invite_code.dart';
import 'package:fino/features/teams/domain/use_cases/transfer_admin.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../orders/domain/support/order_fixtures.dart';
import 'support/team_fixtures.dart';
import 'support/team_matchers.dart';

void main() {
  group('CreateTeam (E1)', () {
    CreateTeam create() => CreateTeam(sequentialIds(), () => 'CODE2345');

    test('creates the team with its creator as admin', () {
      final change = create()(
        creatorId: 'omar',
        name: ' Oficina ',
        creatorName: 'Omar',
        now: t0,
      );

      expect(change.kind, TeamChangeKind.created);
      expect(change.teamId, change.team!.id);
      expect(change.team!.name, 'Oficina');
      expect(change.team!.inviteCode, 'CODE2345');
      expect(change.members.single.userId, 'omar');
      expect(change.members.single.role, TeamRole.admin);
      expect(change.members.single.teamId, change.team!.id);
    });

    test('rejects an empty or too long name', () {
      for (final name in ['  ', 'x' * 51]) {
        expect(
          () => create()(
            creatorId: 'omar',
            name: name,
            creatorName: 'Omar',
            now: t0,
          ),
          throwsTeam(TeamFailureReason.invalidName),
        );
      }
    });
  });

  group('JoinTeam (E2, E4)', () {
    test(
      'joins with the code, ignoring case and separators, and tells admins',
      () {
        final change = const JoinTeam()(
          team: team,
          enteredCode: 'abcd-2345',
          roster: roster,
          userId: 'cris',
          displayName: 'Cris',
          now: t0,
        );

        expect(change.kind, TeamChangeKind.joined);
        expect(change.inviteCode, 'ABCD2345');
        expect(change.members.single.userId, 'cris');
        expect(change.members.single.role, TeamRole.member);
        final notification = change.notifications.single;
        expect(notification.kind, NotificationKind.memberJoined);
        expect(notification.recipientId, 'omar');
        expect(notification.actorId, 'cris');
        expect(notification.target, const NotificationTarget.team('t1'));
      },
    );

    test('someone who is already a member changes nothing', () {
      final change = const JoinTeam()(
        team: team,
        enteredCode: 'ABCD2345',
        roster: roster,
        userId: 'ana',
        displayName: 'Ana',
        now: t0,
      );

      expect(change.isEmpty, isTrue);
      expect(change.members, isEmpty);
      expect(change.notifications, isEmpty);
    });

    test('rejects a wrong code', () {
      expect(
        () => const JoinTeam()(
          team: team,
          enteredCode: 'WRONG000',
          roster: roster,
          userId: 'cris',
          displayName: 'Cris',
          now: t0,
        ),
        throwsTeam(TeamFailureReason.invalidInviteCode),
      );
    });
  });

  group('RegenerateInviteCode (E3)', () {
    test('the admin gets a new, different code', () {
      final codes = ['ABCD2345', 'NEWC0DE2'].iterator;
      String next() {
        codes.moveNext();
        return codes.current;
      }

      final change = RegenerateInviteCode(next)(
        actorId: 'omar',
        team: team,
        roster: roster,
      );

      expect(change.team!.inviteCode, 'NEWC0DE2');
    });

    test('members cannot', () {
      expect(
        () => RegenerateInviteCode(() => 'X')(
          actorId: 'ana',
          team: team,
          roster: roster,
        ),
        throwsTeam(TeamFailureReason.notAdmin),
      );
    });
  });

  group('TransferAdmin (E6)', () {
    test('promotes the target and demotes the admin', () {
      final change = const TransferAdmin()(
        actorId: 'omar',
        targetUserId: 'ana',
        roster: roster,
      );

      expect(change.members.map((m) => (m.userId, m.role)), [
        ('ana', TeamRole.admin),
        ('omar', TeamRole.member),
      ]);
    });

    test('rejects non-admins, self and strangers', () {
      TeamChange transfer(String actor, String target) => const TransferAdmin()(
        actorId: actor,
        targetUserId: target,
        roster: roster,
      );

      expect(
        () => transfer('ana', 'beto'),
        throwsTeam(TeamFailureReason.notAdmin),
      );
      expect(
        () => transfer('omar', 'omar'),
        throwsTeam(TeamFailureReason.cannotTargetSelf),
      );
      expect(
        () => transfer('omar', 'zoe'),
        throwsTeam(TeamFailureReason.targetNotMember),
      );
    });
  });
}
