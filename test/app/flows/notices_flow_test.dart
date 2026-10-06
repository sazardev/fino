import 'package:fino/features/notices/presentation/pages/notice_compose_page.dart';
import 'package:fino/features/orders/presentation/pages/counterpart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/app_harness.dart';
import '../../support/load_fonts.dart';
import '../../support/seed_fino.dart';

/// Avisos: recordar a quien me debe, con el límite de 1 h por persona (A3).
void main() {
  setUpAll(loadGeistFonts);

  Future<void> tapText(WidgetTester tester, String text) async {
    final target = find.text(text).last;
    await tester.ensureVisible(target);
    await tester.pumpAndSettle();
    await tester.tap(target);
    await tester.pumpAndSettle();
  }

  Future<void> remindBeto(WidgetTester tester) async {
    await tapText(tester, 'Beto');
    expect(find.byType(CounterpartPage), findsOneWidget);
    await tapText(tester, 'Recordar');
    expect(find.byType(NoticeComposePage), findsOneWidget);
  }

  testWidgets('remind a debtor: preselected, then sent', (tester) async {
    await pumpFino(tester, seed: seedFino);
    await remindBeto(tester);

    expect(find.text(r'Beto · $100.00'), findsOneWidget);
    await tapText(tester, 'Enviar aviso');

    expect(find.text('Aviso enviado a 1 persona'), findsOneWidget);
    expect(find.byType(NoticeComposePage), findsNothing);
  });

  testWidgets('a second notice within the hour waits', (tester) async {
    await pumpFino(tester, seed: seedFino);
    await remindBeto(tester);
    await tapText(tester, 'Enviar aviso');
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    await tapText(tester, 'Recordar');
    await tapText(tester, 'Enviar aviso');
    expect(find.textContaining('No se envió · 1 en espera'), findsOneWidget);
  });

  testWidgets('a custom message needs text', (tester) async {
    await pumpFino(tester, seed: seedFino);
    await remindBeto(tester);

    await tapText(tester, '¿Ya me pagaste?');
    await tapText(tester, 'Enviar aviso');
    expect(find.text('Escribe un mensaje o elige uno'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Ya paguen 🙏');
    await tapText(tester, 'Enviar aviso');
    expect(find.text('Aviso enviado a 1 persona'), findsOneWidget);
  });
}
