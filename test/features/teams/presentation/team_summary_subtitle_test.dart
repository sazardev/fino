import 'package:fino/features/teams/domain/entities/team.dart';
import 'package:fino/features/teams/domain/entities/team_summary.dart';
import 'package:fino/features/teams/domain/enums/team_role.dart';
import 'package:fino/features/teams/presentation/widgets/team_summary_subtitle.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String subtitle(TeamRole role, int count) => TeamSummarySubtitle.of(
    TeamSummary(
      team: Team(
        id: 't',
        name: 'Oficina',
        inviteCode: 'ABCD2345',
        createdAt: DateTime.utc(2026),
      ),
      role: role,
      memberCount: count,
    ),
  );

  test('says the role and the size', () {
    expect(subtitle(TeamRole.admin, 5), 'Admin · 5 miembros');
    expect(subtitle(TeamRole.member, 3), 'Miembro · 3 miembros');
  });

  test('a team of one is singular', () {
    expect(subtitle(TeamRole.admin, 1), 'Admin · 1 miembro');
  });
}
