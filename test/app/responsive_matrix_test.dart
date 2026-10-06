import 'package:fino/ui/responsive/ui_size.dart';
import 'package:fino/ui/molecules/app_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/app_harness.dart';
import '../support/load_fonts.dart';
import '../support/nav_helpers.dart';

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
        await pumpFino(tester, size: size, stored: {'ui_size': ui.name});
        expect(tester.takeException(), isNull, reason: 'home');

        for (final icon in [galleryIcon, settingsIcon]) {
          await goTo(tester, icon);
          expect(tester.takeException(), isNull, reason: '$icon');
        }

        // A secondary screen, with its floating back button.
        await tester.tap(find.byIcon(Icons.palette_rounded).first);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull, reason: 'appearance');
        await tester.tap(find.byTooltip('Volver'));
        await tester.pumpAndSettle();

        // The full-screen form.
        await goTo(tester, homeIcon);
        await tester.tap(find.byType(AppFab));
        await tester.pumpAndSettle();
        expect(find.text('Nuevo movimiento'), findsOneWidget);
        expect(tester.takeException(), isNull, reason: 'compose');
      });
    }
  }
}
