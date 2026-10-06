import 'package:fino/ui/molecules/app_fab.dart';
import 'package:fino/ui/responsive/ui_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/app_harness.dart';
import '../support/load_fonts.dart';
import '../support/nav_helpers.dart';
import '../support/seed_fino.dart';

/// Walks every destination, a secondary screen and the full-screen form at
/// every screen class and user UI size; any overflow or build error fails.
void main() {
  setUpAll(loadGeistFonts);

  const sizes = {
    'watch': Size(200, 200),
    'phone': Size(390, 844),
    'landscape': Size(844, 390),
    'medium': Size(700, 900),
    'tablet': Size(800, 1280),
    'desktop': Size(1280, 800),
    'web-wide': Size(1920, 1080),
  };

  for (final MapEntry(key: name, value: size) in sizes.entries) {
    for (final ui in [UiSize.small, UiSize.extraLarge]) {
      testWidgets('$name / ${ui.name}', (tester) async {
        await pumpFino(
          tester,
          size: size,
          stored: {'ui_size': ui.name},
          seed: seedFino,
        );
        expect(tester.takeException(), isNull, reason: 'home');

        for (final icon in [ordersIcon, inboxIcon, settingsIcon]) {
          await goTo(tester, icon);
          expect(tester.takeException(), isNull, reason: '$icon');
        }

        // Secondary screens, with their floating back button.
        await _open(tester, find.byIcon(Icons.palette_rounded));
        expect(tester.takeException(), isNull, reason: 'appearance');
        await _back(tester);

        await goTo(tester, ordersIcon);
        await _open(tester, find.text('Café'));
        expect(tester.takeException(), isNull, reason: 'order detail');
        await _back(tester);

        await goTo(tester, homeIcon);
        await _open(tester, find.text('Beto'));
        expect(tester.takeException(), isNull, reason: 'counterpart');
        await _back(tester);

        // The full-screen form.
        await tester.tap(find.byType(AppFab));
        await tester.pumpAndSettle();
        expect(find.text('Nuevo pedido'), findsOneWidget);
        expect(tester.takeException(), isNull, reason: 'new order');
      });
    }
  }
}

Future<void> _open(WidgetTester tester, Finder target) async {
  // Long lists build their rows lazily: scroll until the row exists.
  if (target.evaluate().isEmpty) {
    await tester.dragUntilVisible(
      target,
      find
          .byWidgetPredicate(
            (w) => w is Scrollable && w.axisDirection == AxisDirection.down,
          )
          .hitTestable()
          .first,
      const Offset(0, -80),
    );
  }
  await tester.ensureVisible(target.first);
  await tester.pumpAndSettle();
  await tester.tap(target.first);
  await tester.pumpAndSettle();
}

Future<void> _back(WidgetTester tester) async {
  await tester.tap(find.byTooltip('Volver'));
  await tester.pumpAndSettle();
}
