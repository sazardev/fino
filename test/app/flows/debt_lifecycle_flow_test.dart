import 'package:drift/drift.dart' show Value;
import 'package:fino/core/database/app_database.dart';
import 'package:fino/features/orders/presentation/pages/add_debtor_page.dart';
import 'package:fino/features/orders/presentation/pages/order_detail_page.dart';
import 'package:fino/features/orders/presentation/pages/pay_page.dart';
import 'package:fino/features/orders/presentation/pages/payment_page.dart';
import 'package:fino/features/teams/data/payout_method_type.dart';
import 'package:fino/features/teams/domain/enums/team_role.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/app_harness.dart';
import '../../support/load_fonts.dart';
import '../../support/nav_helpers.dart';
import '../../support/seed_fino.dart';

/// La vida de una deuda desde el detalle del pedido y la pantalla del pago:
/// confirmar, deshacer, cancelar, repartir, sumar a alguien, pagar y retirar.
void main() {
  setUpAll(loadGeistFonts);

  Future<void> tap(WidgetTester tester, Finder finder) async {
    await tester.ensureVisible(finder.first);
    await tester.pumpAndSettle();
    await tester.tap(finder.first);
    await tester.pumpAndSettle();
  }

  Finder on<T extends Widget>(String text) =>
      find.descendant(of: find.byType(T), matching: find.text(text));

  Future<void> openOrder(WidgetTester tester, String concept) async {
    await goTo(tester, ordersIcon);
    await tap(tester, find.text(concept));
    expect(find.byType(OrderDetailPage), findsOneWidget);
  }

  testWidgets('confirm a payment, undo it, cancel another debt', (
    tester,
  ) async {
    await pumpFino(tester, seed: seedFino);
    await openOrder(tester, 'Café');

    await tap(tester, on<OrderDetailPage>('Confirmar'));
    expect(find.text('Pago confirmado'), findsOneWidget);

    await tap(tester, on<OrderDetailPage>('Deshacer'));
    expect(find.text('Confirmación deshecha'), findsOneWidget);

    await tap(tester, on<OrderDetailPage>('Cancelar'));
    expect(find.text('Deuda cancelada'), findsOneWidget);
  });

  testWidgets('redistribute what is pending', (tester) async {
    await pumpFino(tester, seed: seedFino);
    await openOrder(tester, 'Café');

    await tap(tester, find.text('Repartir lo pendiente en partes iguales'));
    expect(find.text('Repartido de nuevo'), findsOneWidget);
  });

  testWidgets('add someone who also owes', (tester) async {
    await pumpFino(
      tester,
      seed: (db) async {
        await seedFino(db);
        await _addDani(db);
      },
    );
    await openOrder(tester, 'Café');

    await tap(tester, find.text('Agregar a alguien'));
    expect(find.byType(AddDebtorPage), findsOneWidget);
    await tap(tester, on<AddDebtorPage>('Dani'));
    await tester.enterText(find.byType(TextField), '50');
    await tap(tester, on<AddDebtorPage>('Agregar'));

    expect(find.text('Agregado: ya le avisamos'), findsOneWidget);
    expect(on<OrderDetailPage>('Dani'), findsOneWidget);
  });

  testWidgets('a debtor pays, then takes the notice back', (tester) async {
    await pumpFino(tester, seed: seedFino);
    await openOrder(tester, 'Comida');

    await tap(tester, on<OrderDetailPage>('Pagar'));
    expect(find.byType(PayPage), findsOneWidget);
    await tap(tester, find.text(r'Ya pagué $100.00'));
    expect(find.text('Listo: le avisamos a Beto'), findsOneWidget);

    await openOrder(tester, 'Comida');
    await tap(tester, on<OrderDetailPage>('Retirar aviso'));
    expect(find.text('Aviso de pago retirado'), findsOneWidget);
    expect(on<OrderDetailPage>('Pagar'), findsOneWidget);
  });

  testWidgets('a reported payment is confirmed from its own screen', (
    tester,
  ) async {
    await pumpFino(tester, seed: seedFino, initialLocation: '/pagos/p1');
    expect(find.byType(PaymentPage), findsOneWidget);
    expect(on<PaymentPage>('Carla dice que te pagó'), findsOneWidget);
    expect(on<PaymentPage>(r'+$100.00'), findsWidgets);

    await tap(tester, on<PaymentPage>('Confirmar todo'));
    expect(find.text('Pago confirmado'), findsOneWidget);
    expect(on<PaymentPage>('Confirmar todo'), findsNothing);
  });
}

/// Una cuarta persona en el equipo, sin deudas.
Future<void> _addDani(AppDatabase db) async {
  await db.teamsDao.upsertMember(
    TeamMembersCompanion.insert(
      teamId: 't1',
      userId: 'u4',
      role: TeamRole.member,
      joinedAt: seededAt,
      displayName: 'Dani',
    ),
  );
  await db.teamsDao.upsertPayoutMethod(
    PayoutMethodsCompanion.insert(
      teamId: 't1',
      userId: 'u4',
      type: PayoutMethodType.card,
      number: '4152313312345678',
      bankName: const Value('BBVA'),
    ),
  );
}
