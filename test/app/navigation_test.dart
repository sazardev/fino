import 'package:fino/app/gallery/gallery_page.dart';
import 'package:fino/app/settings/appearance_page.dart';
import 'package:fino/app/settings/settings_page.dart';
import 'package:fino/ui/molecules/app_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/app_harness.dart';
import '../support/load_fonts.dart';
import '../support/nav_helpers.dart';

/// The gallery's switch (other pages stay mounted, hidden, with their own).
final Finder _gallerySwitch = find.descendant(
  of: find.byType(GalleryPage),
  matching: find.byType(Switch),
);
final Finder _fab = find.byType(AppFab);

Future<void> _toggleGallerySwitch(WidgetTester tester) async {
  await tester.scrollUntilVisible(
    _gallerySwitch,
    200,
    scrollable: find.descendant(
      of: find.byType(GalleryPage),
      matching: find.byType(Scrollable),
    ),
  );
  await tester.tap(_gallerySwitch);
  await tester.pumpAndSettle();
}

bool _galleryValue(WidgetTester tester) =>
    tester.widget<Switch>(_gallerySwitch).value;

void main() {
  setUpAll(loadGeistFonts);

  group('navigation follows the window width, not the platform', () {
    testWidgets('compact: bottom bar, no rail', (tester) async {
      await pumpFino(tester);
      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.byType(NavigationRail), findsNothing);
    });

    testWidgets('medium: compact rail, no bar', (tester) async {
      await pumpFino(tester, size: const Size(700, 900));
      expect(find.byType(NavigationBar), findsNothing);
      final rail = tester.widget<NavigationRail>(find.byType(NavigationRail));
      expect(rail.extended, isFalse);
    });

    testWidgets('expanded: extended rail', (tester) async {
      await pumpFino(tester, size: const Size(1280, 800));
      expect(find.byType(NavigationBar), findsNothing);
      final rail = tester.widget<NavigationRail>(find.byType(NavigationRail));
      expect(rail.extended, isTrue);
    });

    testWidgets('a phone in landscape gets a rail too', (tester) async {
      await pumpFino(tester, size: const Size(844, 390));
      expect(find.byType(NavigationRail), findsOneWidget);
    });
  });

  for (final size in const [
    Size(200, 200),
    Size(390, 844),
    Size(800, 1280),
    Size(1280, 800),
  ]) {
    testWidgets('no AppBar on any destination at $size', (tester) async {
      await pumpFino(tester, size: size);
      for (final icon in [homeIcon, galleryIcon, settingsIcon]) {
        await goTo(tester, icon);
        expect(find.byType(AppBar), findsNothing, reason: '$icon');
      }
    });
  }

  testWidgets('the destination is not repeated as a title', (tester) async {
    await pumpFino(tester);
    await goTo(tester, settingsIcon);
    // Only the bar's own label: the page adds no "Ajustes" heading.
    expect(find.text('Ajustes'), findsOneWidget);
  });

  testWidgets('pages keep their state across destinations', (tester) async {
    await pumpFino(tester);
    await goTo(tester, galleryIcon);
    expect(_galleryValue(tester), isTrue);

    await _toggleGallerySwitch(tester);
    expect(_galleryValue(tester), isFalse);

    await goTo(tester, homeIcon);
    await goTo(tester, galleryIcon);
    expect(_galleryValue(tester), isFalse);
  });

  testWidgets('resizing bar ↔ rail keeps destination and state', (
    tester,
  ) async {
    await pumpFino(tester);
    await goTo(tester, galleryIcon);
    await _toggleGallerySwitch(tester);

    await resizeTo(tester, const Size(1280, 800));
    expect(find.byType(NavigationRail), findsOneWidget);
    expect(_galleryValue(tester), isFalse);

    await resizeTo(tester, const Size(390, 844));
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(_galleryValue(tester), isFalse);
  });

  group('secondary screens', () {
    Future<void> openAppearance(WidgetTester tester) async {
      await goTo(tester, settingsIcon);
      await tester.tap(find.text('Apariencia'));
      await tester.pumpAndSettle();
    }

    testWidgets('open inside the destination: navigation stays', (
      tester,
    ) async {
      await pumpFino(tester);
      await openAppearance(tester);

      expect(find.byType(AppearancePage), findsOneWidget);
      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.byTooltip('Volver'), findsOneWidget);
    });

    testWidgets('the floating back button returns', (tester) async {
      await pumpFino(tester);
      await openAppearance(tester);

      await tester.tap(find.byTooltip('Volver'));
      await tester.pumpAndSettle();

      expect(find.byType(SettingsPage), findsOneWidget);
      expect(find.byTooltip('Volver'), findsNothing);
    });

    testWidgets('the system back pops the destination first', (tester) async {
      await pumpFino(tester);
      await openAppearance(tester);

      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();

      expect(find.byType(SettingsPage), findsOneWidget);
      expect(find.byType(AppearancePage), findsNothing);
    });

    testWidgets('reselecting the active destination returns to its root', (
      tester,
    ) async {
      await pumpFino(tester);
      await openAppearance(tester);

      await goTo(tester, settingsIcon);

      expect(find.byType(AppearancePage), findsNothing);
      expect(find.byType(SettingsPage), findsOneWidget);
    });
  });

  group('primary action', () {
    testWidgets('opens a full-screen form above the navigation', (
      tester,
    ) async {
      await pumpFino(tester);
      await tester.tap(_fab);
      await tester.pumpAndSettle();

      expect(find.text('Nuevo movimiento'), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);

      await tester.tap(find.byTooltip('Volver'));
      await tester.pumpAndSettle();
      expect(find.byType(NavigationBar), findsOneWidget);
    });

    testWidgets('only the first destination has one', (tester) async {
      await pumpFino(tester);
      expect(_fab, findsOneWidget);
      await goTo(tester, settingsIcon);
      expect(_fab, findsNothing);
    });

    testWidgets('lives atop the rail on wide screens, with its label', (
      tester,
    ) async {
      await pumpFino(tester, size: const Size(1280, 800));
      expect(_fab, findsOneWidget);
      expect(find.text('Nuevo'), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsNothing);
    });

    testWidgets('shows only its icon on compact screens', (tester) async {
      await pumpFino(tester);
      expect(find.text('Nuevo'), findsNothing);
    });
  });
}
