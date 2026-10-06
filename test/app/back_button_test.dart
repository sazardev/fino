import 'package:fino/app/gallery/gallery_page.dart';
import 'package:fino/app/home/home_page.dart';
import 'package:fino/app/settings/appearance_page.dart';
import 'package:fino/app/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/app_harness.dart';
import '../support/load_fonts.dart';
import '../support/nav_helpers.dart';

/// The floating back button belongs to secondary screens only: a destination's
/// root never shows it, whatever the window size or the way we got there.
void main() {
  setUpAll(loadGeistFonts);

  Finder backIn(Type page) => find.descendant(
    of: find.byType(page),
    matching: find.byTooltip('Volver'),
  );

  const sizes = {
    'phone': Size(390, 844),
    'tablet': Size(800, 1280),
    'desktop': Size(1280, 800),
    'web-wide': Size(1920, 1080),
  };

  for (final MapEntry(key: name, value: size) in sizes.entries) {
    group(name, () {
      testWidgets('the root of Ajustes stays free after visiting a child', (
        tester,
      ) async {
        await pumpFino(tester, size: size);
        await goTo(tester, settingsIcon);
        await tester.tap(find.text('Apariencia'));
        await tester.pumpAndSettle();
        expect(backIn(AppearancePage), findsOneWidget);

        await goTo(tester, homeIcon);
        await goTo(tester, settingsIcon);

        expect(backIn(SettingsPage), findsNothing);
      });

      testWidgets('resizing with a child open leaves the root free', (
        tester,
      ) async {
        await pumpFino(tester, size: size);
        await goTo(tester, settingsIcon);
        await tester.tap(find.text('Apariencia'));
        await tester.pumpAndSettle();

        await resizeTo(tester, Size(size.width + 40, size.height));
        await tester.tap(find.byTooltip('Volver'));
        await tester.pumpAndSettle();

        expect(find.byType(SettingsPage), findsOneWidget);
        expect(backIn(SettingsPage), findsNothing);
      });

      testWidgets('no destination root ever shows it', (tester) async {
        await pumpFino(tester, size: size);
        await goTo(tester, galleryIcon);
        expect(backIn(GalleryPage), findsNothing);
        await goTo(tester, settingsIcon);
        expect(backIn(SettingsPage), findsNothing);
      });
    });
  }

  group('deep links', () {
    testWidgets('a child opened from its URL goes back to its parent', (
      tester,
    ) async {
      await pumpFino(tester, initialLocation: '/ajustes/apariencia');
      expect(find.byType(AppearancePage), findsOneWidget);

      await tester.tap(find.byTooltip('Volver'));
      await tester.pumpAndSettle();

      expect(find.byType(SettingsPage), findsOneWidget);
    });

    testWidgets('a top-level screen with nothing below goes home', (
      tester,
    ) async {
      await pumpFino(tester, initialLocation: '/nuevo');
      expect(find.text('Nuevo movimiento'), findsOneWidget);

      await tester.tap(find.byTooltip('Volver'));
      await tester.pumpAndSettle();

      expect(find.text('Nuevo movimiento'), findsNothing);
      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('the changelog goes back to Ajustes', (tester) async {
      await pumpFino(tester, initialLocation: '/ajustes/novedades');

      await tester.tap(find.byTooltip('Volver'));
      await tester.pumpAndSettle();

      expect(find.byType(SettingsPage), findsOneWidget);
    });
  });
}
