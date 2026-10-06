import 'package:fino/features/orders/presentation/pages/counterpart_page.dart';
import 'package:fino/features/orders/presentation/pages/pay_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/app_harness.dart';
import '../../support/load_fonts.dart';
import '../../support/seed_fino.dart';

/// Inicio de punta a punta: saldos, confirmar lo reportado, pagar y recordar.
void main() {
  setUpAll(loadGeistFonts);

  Future<void> tapText(WidgetTester tester, String text, {int at = 0}) async {
    final target = find.text(text).at(at);
    await tester.ensureVisible(target);
    await tester.pumpAndSettle();
    await tester.tap(target);
    await tester.pumpAndSettle();
  }

  testWidgets('shows what I am owed, what I owe and what awaits me', (
    tester,
  ) async {
    await pumpFino(tester, seed: seedFino);

    expect(find.text('Te deben'), findsWidgets);
    expect(find.text(r'+$200.00'), findsOneWidget);
    expect(find.text(r'−$100.00'), findsWidgets);
    expect(find.text(r'Carla dice que ya te pagó $100.00'), findsOneWidget);
  });

  testWidgets('confirming a reported payment clears it (G5)', (tester) async {
    await pumpFino(tester, seed: seedFino);

    await tapText(tester, 'Confirmar');

    expect(find.text('Pago confirmado'), findsOneWidget);
    expect(find.text('Por confirmar'), findsNothing);
    expect(find.text(r'+$100.00'), findsWidgets);
  });

  testWidgets('paying Beto: account to copy, then "Ya pagué" (6.3)', (
    tester,
  ) async {
    await pumpFino(tester, seed: seedFino);

    await tapText(tester, 'Beto');
    expect(find.byType(CounterpartPage), findsOneWidget);
    expect(find.text('Le debes'), findsOneWidget);
    expect(find.text('Te debe'), findsOneWidget);

    await tapText(tester, r'Pagar $100.00');
    expect(find.byType(PayPage), findsOneWidget);
    expect(find.text('Pagar a Beto'), findsOneWidget);
    expect(find.text('0121 8000 0112 3456 71'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'SPEI-77');
    await tapText(tester, r'Ya pagué $100.00');

    expect(find.text('Listo: le avisamos a Beto'), findsOneWidget);
    expect(find.byType(CounterpartPage), findsOneWidget);
    expect(find.text('Esperando confirmación'), findsOneWidget);
  });

  testWidgets('a payment can leave a debt out (G1)', (tester) async {
    await pumpFino(tester, seed: seedFino);
    await tapText(tester, 'Beto');
    await tapText(tester, r'Pagar $100.00');

    await tapText(tester, 'Comida');

    expect(find.text('Fuera de este pago'), findsOneWidget);
    expect(find.text(r'Ya pagué $0.00'), findsOneWidget);
  });

  testWidgets('reminding someone opens a notice for them (SPEC 8)', (
    tester,
  ) async {
    await pumpFino(tester, seed: seedFino);
    await tapText(tester, 'Beto', at: 1);

    await tapText(tester, 'Recordar');
    expect(find.text('Nuevo aviso'), findsOneWidget);

    await tapText(tester, 'Enviar aviso');
    expect(find.textContaining('Aviso enviado a 1 persona'), findsOneWidget);
  });
}
