import 'package:fino/features/orders/presentation/pages/order_detail_page.dart';
import 'package:fino/ui/molecules/app_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/app_harness.dart';
import '../../support/load_fonts.dart';
import '../../support/nav_helpers.dart';
import '../../support/seed_fino.dart';

/// Pedidos de punta a punta: buscar, actuar sobre deudas, registrar y editar.
void main() {
  setUpAll(loadGeistFonts);

  Future<void> tapText(WidgetTester tester, String text) async {
    final target = find.text(text).first;
    await tester.ensureVisible(target);
    await tester.pumpAndSettle();
    await tester.tap(target);
    await tester.pumpAndSettle();
  }

  testWidgets('searching and filtering the list', (tester) async {
    await pumpFino(tester, seed: seedFino);
    await goTo(tester, ordersIcon);
    expect(find.text('Café'), findsOneWidget);
    expect(find.text('Comida'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'comi');
    await tester.pumpAndSettle();
    expect(find.text('Café'), findsNothing);

    await tapText(tester, 'Saldados');
    expect(find.text('Nada coincide'), findsOneWidget);
  });

  testWidgets('the creditor rejects a payment and edits an amount', (
    tester,
  ) async {
    await pumpFino(tester, seed: seedFino);
    await goTo(tester, ordersIcon);
    await tapText(tester, 'Café');
    expect(find.byType(OrderDetailPage), findsOneWidget);

    await tapText(tester, 'No me llegó');
    await tester.enterText(find.byType(TextField), 'nada en el banco');
    await tapText(tester, 'Rechazar pago');
    expect(find.text('Pago rechazado'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(OrderDetailPage),
        matching: find.text('Por confirmar'),
      ),
      findsNothing,
    );

    await tapText(tester, 'Cambiar monto');
    await tester.enterText(find.byType(TextField), '80');
    await tapText(tester, 'Guardar monto');
    expect(find.text('Monto actualizado'), findsOneWidget);
    expect(find.text(r'+$80.00'), findsOneWidget);
  });

  testWidgets('registering a new order with a live split, then cancelling', (
    tester,
  ) async {
    await pumpFino(tester, seed: seedFino);
    await tester.tap(find.byType(AppFab));
    await tester.pumpAndSettle();
    expect(find.text('Nuevo pedido'), findsOneWidget);

    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), 'Pizza');
    await tester.enterText(fields.at(1), '300');
    await tester.pumpAndSettle();
    await tapText(tester, 'Beto');
    await tapText(tester, 'Carla');
    expect(find.text(r'$100.00'), findsWidgets);

    await tapText(tester, 'Registrar pedido');
    expect(find.byType(OrderDetailPage), findsOneWidget);
    expect(find.text('Pizza'), findsOneWidget);

    await tapText(tester, 'Cancelar pedido');
    await tapText(tester, 'Confirmar: cancelar pedido');
    expect(find.text('Pedido cancelado'), findsOneWidget);
  });

  testWidgets('editing an order', (tester) async {
    await pumpFino(tester, seed: seedFino);
    await goTo(tester, ordersIcon);
    await tapText(tester, 'Café');

    await tapText(tester, 'Editar pedido');
    await tester.enterText(find.byType(TextField).first, 'Café y pan');
    await tapText(tester, 'Guardar cambios');

    expect(find.text('Pedido actualizado'), findsOneWidget);
    expect(find.text('Café y pan'), findsOneWidget);
  });

  testWidgets('a debtor sees their own actions on the order', (tester) async {
    await pumpFino(tester, seed: seedFino);
    await goTo(tester, ordersIcon);
    await tapText(tester, 'Comida');

    expect(find.text('Pagar'), findsOneWidget);
    await tapText(tester, 'Objetar');
    await tester.enterText(find.byType(TextField), 'yo no comí');
    await tapText(tester, 'Enviar objeción');
    expect(find.text('Objeción enviada'), findsOneWidget);
  });
}
