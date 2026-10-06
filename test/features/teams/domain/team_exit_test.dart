import 'package:fino/features/teams/domain/entities/live_debts.dart';
import 'package:fino/features/teams/domain/entities/team_change.dart';
import 'package:fino/features/teams/domain/entities/team_roster.dart';
import 'package:fino/features/teams/domain/enums/team_change_kind.dart';
import 'package:fino/features/teams/domain/enums/team_role.dart';
import 'package:fino/features/teams/domain/failures/team_failure.dart';
import 'package:fino/features/teams/domain/failures/team_failure_reason.dart';
import 'package:fino/features/teams/domain/use_cases/delete_team.dart';
import 'package:fino/features/teams/domain/use_cases/expel_member.dart';
import 'package:fino/features/teams/domain/use_cases/leave_team.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/team_fixtures.dart';
import 'support/team_matchers.dart';

void main() {
  group('LeaveTeam (4.2, E6)', () {
    TeamChange leave(String user, {LiveDebts debts = LiveDebts.none}) =>
        const LeaveTeam()(userId: user, roster: roster, liveDebts: debts);

    test('a member without live debts leaves', () {
      expect(leave('ana').removedUserIds, ['ana']);
      expect(leave('ana').kind, TeamChangeKind.membersRemoved);
      expect(leave('ana').teamId, 't1');
    });

    test('live debts block leaving and say which', () {
      expect(
        () => leave('ana', debts: live),
        throwsA(
          isA<TeamFailure>()
              .having((e) => e.reason, 'reason', TeamFailureReason.hasLiveDebts)
              .having((e) => e.blocking, 'blocking', live),
        ),
      );
    });

    test('the admin must transfer first, or delete the team if alone', () {
      expect(
        () => leave('omar'),
        throwsTeam(TeamFailureReason.adminMustTransfer),
      );
      expect(
        () => const LeaveTeam()(
          userId: 'omar',
          roster: TeamRoster([member('omar', TeamRole.admin)]),
          liveDebts: LiveDebts.none,
        ),
        throwsTeam(TeamFailureReason.adminMustDeleteTeam),
      );
    });

    test('a stranger cannot leave', () {
      expect(() => leave('zoe'), throwsTeam(TeamFailureReason.notMember));
    });
  });

  group('ExpelMember (4.2)', () {
    TeamChange expel(
      String actor,
      String target, {
      LiveDebts debts = LiveDebts.none,
    }) => const ExpelMember()(
      actorId: actor,
      targetUserId: target,
      roster: roster,
      targetLiveDebts: debts,
    );

    test('the admin expels a member without live debts', () {
      expect(expel('omar', 'ana').removedUserIds, ['ana']);
    });

    test('rejects non-admins, self, strangers and live debts', () {
      expect(
        () => expel('ana', 'beto'),
        throwsTeam(TeamFailureReason.notAdmin),
      );
      expect(
        () => expel('omar', 'omar'),
        throwsTeam(TeamFailureReason.cannotTargetSelf),
      );
      expect(
        () => expel('omar', 'zoe'),
        throwsTeam(TeamFailureReason.targetNotMember),
      );
      expect(
        () => expel('omar', 'ana', debts: live),
        throwsTeam(TeamFailureReason.hasLiveDebts),
      );
    });
  });

  group('DeleteTeam (4.2)', () {
    TeamChange delete(String actor, {LiveDebts debts = LiveDebts.none}) =>
        const DeleteTeam()(
          actorId: actor,
          team: team,
          roster: roster,
          teamLiveDebts: debts,
        );

    test('the admin deletes a team with no live debts', () {
      expect(delete('omar').kind, TeamChangeKind.deleted);
      expect(delete('omar').teamId, 't1');
      expect(delete('omar').removedUserIds, ['omar', 'ana', 'beto']);
    });

    test('rejects members and live debts', () {
      expect(() => delete('ana'), throwsTeam(TeamFailureReason.notAdmin));
      expect(
        () => delete('omar', debts: live),
        throwsTeam(TeamFailureReason.hasLiveDebts),
      );
    });
  });
}
