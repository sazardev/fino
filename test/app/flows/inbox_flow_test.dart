import 'package:fino/features/inbox/presentation/pages/inbox_page.dart';
import 'package:fino/features/orders/presentation/pages/order_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/app_harness.dart';
import '../../support/load_fonts.dart';
import '../../support/nav_helpers.dart';
import '../../support/seed_fino.dart';

/// El buzón: el número en la navegación, leer y llegar a lo que cambió.
void main() {
  setUpAll(loadGeistFonts);

  Finder inInbox(Finder finder) =>
      find.descendant(of: find.byType(InboxPage), matching: finder);

  testWidgets('the unread count rides on "Buzón"', (tester) async {
    await pumpFino(tester, seed: seedFino);

    expect(find.byType(Badge), findsWidgets);
    expect(find.text('1'), findsWidgets);
  });

  testWidgets('a notification reads well and leads to its order (N3)', (
    tester,
  ) async {
    await pumpFino(tester, seed: seedFino);
    await goTo(tester, inboxIcon);

    expect(
      inInbox(find.text(r'Beto registró Comida: debes $200.00')),
      findsOneWidget,
    );
    expect(inInbox(find.text('1 sin leer')), findsOneWidget);

    await tester.tap(inInbox(find.textContaining('Beto registró')));
    await tester.pumpAndSettle();
    expect(find.byType(OrderDetailPage), findsOneWidget);
    expect(find.text('Comida'), findsWidgets);

    await goTo(tester, inboxIcon);
    expect(inInbox(find.text('1 sin leer')), findsNothing);
  });

  testWidgets('mark all read, then swipe to delete', (tester) async {
    await pumpFino(tester, seed: seedFino);
    await goTo(tester, inboxIcon);

    await tester.tap(inInbox(find.text('Marcar todo como leído')));
    await tester.pumpAndSettle();
    expect(inInbox(find.text('1 sin leer')), findsNothing);

    await tester.drag(
      inInbox(find.textContaining('Beto registró')),
      const Offset(-600, 0),
    );
    await tester.pumpAndSettle();
    expect(inInbox(find.text('Nada nuevo')), findsOneWidget);
  });
}
