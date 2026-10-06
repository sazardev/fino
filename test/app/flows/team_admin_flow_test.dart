import 'package:fino/features/teams/presentation/pages/team_detail_page.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/app_harness.dart';
import '../../support/load_fonts.dart';
import '../../support/nav_helpers.dart';
import '../../support/seed_fino.dart';

/// Lo que hace el admin desde el detalle del equipo (E3–E6, §4.2).
void main() {
  setUpAll(loadGeistFonts);

  Future<void> tapText(WidgetTester tester, String text) async {
    final target = find
        .descendant(of: find.byType(TeamDetailPage), matching: find.text(text))
        .first;
    await tester.ensureVisible(target);
    await tester.pumpAndSettle();
    await tester.tap(target);
    await tester.pumpAndSettle();
  }

  Future<void> openOffice(WidgetTester tester) async {
    await pumpFino(tester, seed: seedFino);
    await goTo(tester, settingsIcon);
    final office = find.text('Oficina').last;
    await tester.ensureVisible(office);
    await tester.pumpAndSettle();
    await tester.tap(office);
    await tester.pumpAndSettle();
  }

  testWidgets('a new invite code replaces the old one', (tester) async {
    await openOffice(tester);

    await tapText(tester, 'Cambiar código');
    await tapText(tester, 'Confirmar: cambiar código');

    expect(find.text('Código nuevo listo'), findsOneWidget);
    expect(find.text('ABCD 2345'), findsNothing);
  });

  testWidgets('expelling someone with live debts is blocked', (tester) async {
    await openOffice(tester);

    await tapText(tester, 'Carla');
    await tapText(tester, 'Expulsar a Carla');
    await tapText(tester, 'Confirmar: expulsar');

    expect(find.text('Carla salió del equipo'), findsNothing);
    expect(find.textContaining('deudas'), findsWidgets);
  });

  testWidgets('hand over the admin role, then try to leave', (tester) async {
    await openOffice(tester);

    await tapText(tester, 'Beto');
    await tapText(tester, 'Hacer admin a Beto');
    await tapText(tester, 'Confirmar: pasarle el rol');
    expect(find.text('Beto ahora es admin'), findsOneWidget);

    await tapText(tester, 'Salir del equipo');
    await tapText(tester, 'Confirmar: salir');
    expect(find.textContaining('Primero resuelve las deudas'), findsOneWidget);
  });
}
