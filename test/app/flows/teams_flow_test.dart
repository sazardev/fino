import 'package:fino/features/teams/data/team_store_provider.dart';
import 'package:fino/features/teams/domain/entities/invite_info.dart';
import 'package:fino/features/teams/presentation/pages/team_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/app_harness.dart';
import '../../support/fake_invite_lookup.dart';
import '../../support/load_fonts.dart';
import '../../support/nav_helpers.dart';
import '../../support/seed_fino.dart';

/// Equipos desde Ajustes: detalle, cuenta de cobro, crear, entrar y salir.
void main() {
  setUpAll(loadGeistFonts);

  Future<void> tapText(WidgetTester tester, String text) async {
    final target = find.text(text).last;
    await tester.ensureVisible(target);
    await tester.pumpAndSettle();
    await tester.tap(target);
    await tester.pumpAndSettle();
  }

  Future<void> openOffice(WidgetTester tester) async {
    await goTo(tester, settingsIcon);
    await tapText(tester, 'Oficina');
  }

  testWidgets('team detail: code, members and my payout method', (
    tester,
  ) async {
    await pumpFino(tester, seed: seedFino);
    await openOffice(tester);

    expect(find.byType(TeamDetailPage), findsOneWidget);
    expect(find.text('ABCD 2345'), findsOneWidget);
    expect(find.text('Ana (tú)'), findsOneWidget);
    expect(find.text('Miembros (3)'), findsOneWidget);
    expect(find.text('CLABE ···5671 · BBVA'), findsOneWidget);
  });

  testWidgets('changing the payout method validates its format (M3)', (
    tester,
  ) async {
    await pumpFino(tester, seed: seedFino);
    await openOffice(tester);
    await tapText(tester, 'Cambiar');

    await tapText(tester, 'Tarjeta');
    await tester.enterText(find.byType(TextField).at(0), '123');
    await tapText(tester, 'Guardar cuenta');
    expect(find.text('La tarjeta debe tener 16 dígitos'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), '4152 3133 1234 5678');
    await tapText(tester, 'Guardar cuenta');
    expect(find.text('Cuenta guardada'), findsOneWidget);
    expect(find.text('Tarjeta ···5678 · BBVA'), findsOneWidget);
  });

  testWidgets('a team with live debts cannot be deleted (4.2)', (tester) async {
    await pumpFino(tester, seed: seedFino);
    await openOffice(tester);

    await tapText(tester, 'Eliminar equipo');
    await tapText(tester, 'Confirmar: eliminar equipo');

    expect(find.textContaining('Primero resuelve las deudas'), findsOneWidget);
  });

  testWidgets('creating a team lands on it', (tester) async {
    await pumpFino(tester);
    await goTo(tester, settingsIcon);
    await tapText(tester, 'Crear equipo');

    await tester.enterText(find.byType(TextField), 'Los del café');
    await tapText(tester, 'Crear equipo');

    expect(find.byType(TeamDetailPage), findsOneWidget);
    expect(find.text('Los del café'), findsWidgets);
  });

  testWidgets('joining with a code lands on the team (E2)', (tester) async {
    await pumpFino(
      tester,
      extra: [
        inviteLookupProvider.overrideWithValue(
          FakeInviteLookup({
            'ABCD2345': const InviteInfo(teamId: 't9', teamName: 'Viernes'),
          }),
        ),
      ],
    );
    await goTo(tester, settingsIcon);
    await tapText(tester, 'Entrar con código');

    await tester.enterText(find.byType(TextField), 'nope0000');
    await tapText(tester, 'Entrar al equipo');
    expect(find.textContaining('Ese código no existe'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'abcd 2345');
    await tapText(tester, 'Entrar al equipo');
    expect(find.byType(TeamDetailPage), findsOneWidget);
    expect(find.text('Viernes'), findsWidgets);
  });
}
