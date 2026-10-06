import 'package:fino/features/teams/domain/entities/live_debts.dart';
import 'package:fino/features/teams/domain/entities/team.dart';
import 'package:fino/features/teams/domain/entities/team_member.dart';
import 'package:fino/features/teams/domain/entities/team_roster.dart';
import 'package:fino/features/teams/domain/enums/team_role.dart';

import '../../../orders/domain/support/order_fixtures.dart';

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

final roster = TeamRoster([
  member('omar', TeamRole.admin),
  member('ana'),
  member('beto'),
]);

const live = LiveDebts(asDebtor: 2, asCreditor: 1);
