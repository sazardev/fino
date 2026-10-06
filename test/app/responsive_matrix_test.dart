import 'package:fino/app/gallery/gallery_page.dart';
import 'package:fino/app/settings/appearance_page.dart';
import 'package:fino/ui/responsive/ui_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/app_harness.dart';
import '../support/load_fonts.dart';

/// Renders every screen at every screen class and user UI size; any overflow
/// or build error fails the test.
void main() {
  setUpAll(loadGeistFonts);

  const sizes = {
    'watch': Size(200, 200),
    'phone': Size(390, 844),
    'landscape': Size(844, 390),
    'tablet': Size(800, 1280),
    'desktop': Size(1280, 800),
  };

  for (final MapEntry(key: name, value: size) in sizes.entries) {
    for (final ui in [UiSize.small, UiSize.extraLarge]) {
      testWidgets('$name / ${ui.name}', (tester) async {
        await pumpFino(tester, size: size, stored: {'ui_size': ui.name});
        expect(tester.takeException(), isNull, reason: 'home');

        final nav = tester.state<NavigatorState>(find.byType(Navigator));
        for (final page in const [AppearancePage(), GalleryPage()]) {
          nav.push(MaterialPageRoute<void>(builder: (_) => page));
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull, reason: '${page.runtimeType}');
          nav.pop();
          await tester.pumpAndSettle();
        }
      });
    }
  }
}
