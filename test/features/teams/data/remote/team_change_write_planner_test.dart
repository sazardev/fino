import 'package:fino/features/teams/data/remote/team_change_write_planner.dart';
import 'package:fino/features/teams/domain/entities/team.dart';
import 'package:fino/features/teams/domain/entities/team_change.dart';
import 'package:fino/features/teams/domain/entities/team_member.dart';
import 'package:fino/features/teams/domain/enums/team_change_kind.dart';
import 'package:fino/features/teams/domain/enums/team_role.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../orders/domain/support/order_fixtures.dart';

void main() {
  const planner = TeamChangeWritePlanner();
  final team = Team(
    id: 't1',
    name: 'Oficina',
    inviteCode: 'ABCD2345',
    createdAt: t0,
  );
  TeamMember member(String id, [TeamRole role = TeamRole.member]) => TeamMember(
    teamId: 't1',
    userId: id,
    role: role,
    joinedAt: t0,
    displayName: id,
  );

  List<String> paths(TeamChange change) =>
      planner.plan(change).map((w) => w.path).toList();

  test('every kind of change picks its writes', () {
    expect(paths(TeamChange.empty), isEmpty);
    expect(
      paths(
        TeamChange(
          kind: TeamChangeKind.created,
          teamId: 't1',
          team: team,
          members: [member('omar', TeamRole.admin)],
        ),
      ),
      ['teams/t1', 'teams/t1/members/omar', 'invites/ABCD2345'],
    );
    expect(
      paths(
        TeamChange(
          kind: TeamChangeKind.joined,
          teamId: 't1',
          inviteCode: 'ABCD2345',
          members: [member('zoe')],
        ),
      ),
      ['teams/t1/members/zoe', 'teams/t1'],
    );
    expect(
      paths(
        TeamChange(
          kind: TeamChangeKind.inviteRegenerated,
          teamId: 't1',
          team: team.copyWith(inviteCode: 'NEWC0DE2'),
          previousInviteCode: 'ABCD2345',
        ),
      ),
      ['teams/t1', 'invites/ABCD2345', 'invites/NEWC0DE2'],
    );
    expect(
      paths(TeamChange(kind: TeamChangeKind.deleted, teamId: 't1', team: team)),
      ['teams/t1', 'invites/ABCD2345'],
    );
    expect(
      paths(
        const TeamChange(
          kind: TeamChangeKind.membersRemoved,
          teamId: 't1',
          removedUserIds: ['ana'],
        ),
      ),
      ['teams/t1/members/ana', 'teams/t1'],
    );
    expect(
      paths(
        TeamChange(
          kind: TeamChangeKind.adminTransferred,
          teamId: 't1',
          members: [member('ana', TeamRole.admin), member('omar')],
        ),
      ),
      ['teams/t1', 'teams/t1/members/ana', 'teams/t1/members/omar'],
    );
    expect(
      paths(
        TeamChange(
          kind: TeamChangeKind.profileUpdated,
          teamId: 't1',
          members: [member('ana')],
        ),
      ),
      ['teams/t1/members/ana'],
    );
  });
}
