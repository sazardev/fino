import 'package:fino/features/teams/domain/entities/team.dart';
import 'package:fino/features/teams/domain/entities/team_summary.dart';
import 'package:fino/features/teams/domain/enums/team_role.dart';
import 'package:fino/features/teams/presentation/navigation/teams_navigator_provider.dart';
import 'package:fino/features/teams/presentation/providers/teams_repository_provider.dart';
import 'package:fino/features/teams/presentation/widgets/teams_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../support/fake_teams_navigator.dart';
import '../../../support/fake_teams_repository.dart';
import '../../../support/load_fonts.dart';

TeamSummary _summary(String name, TeamRole role, int size) => TeamSummary(
  team: Team(
    id: name,
    name: name,
    inviteCode: 'ABCD2345',
    createdAt: DateTime.utc(2026),
  ),
  role: role,
  memberCount: size,
);

void main() {
  setUpAll(loadGeistFonts);
  late FakeTeamsNavigator navigator;
  setUp(() => navigator = FakeTeamsNavigator());

  Future<void> pumpSection(
    WidgetTester tester,
    List<TeamSummary> teams, {
    String userId = 'omar',
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          teamsRepositoryProvider.overrideWithValue(
            FakeTeamsRepository(userId: 'omar', teams: teams),
          ),
          teamsNavigatorProvider.overrideWithValue(navigator),
        ],
        child: MaterialApp(
          home: Scaffold(body: TeamsSection(userId: userId)),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('with no teams it offers to create or join one', (tester) async {
    await pumpSection(tester, const []);

    expect(find.text('Crear equipo'), findsOneWidget);
    expect(find.text('Entrar con código'), findsOneWidget);

    await tester.tap(find.text('Crear equipo'));
    await tester.tap(find.text('Entrar con código'));
    expect(navigator.calls, ['create', 'join']);
  });

  testWidgets("shows nothing for someone else's id", (tester) async {
    await pumpSection(tester, [
      _summary('Oficina', TeamRole.admin, 2),
    ], userId: 'ana');

    expect(find.text('Oficina'), findsNothing);
  });

  testWidgets('lists each team with the role and size', (tester) async {
    await pumpSection(tester, [
      _summary('Oficina', TeamRole.admin, 5),
      _summary('Viernes', TeamRole.member, 3),
    ]);

    expect(find.text('Equipos'), findsOneWidget);
    expect(find.text('Oficina'), findsOneWidget);
    expect(find.text('Admin · 5 miembros'), findsOneWidget);
    expect(find.text('Viernes'), findsOneWidget);
    expect(find.text('Miembro · 3 miembros'), findsOneWidget);

    await tester.tap(find.text('Viernes'));
    expect(navigator.calls, ['team:Viernes']);
  });
}
