import 'package:fino/app/settings/appearance_page.dart';
import 'package:fino/app/settings/settings_page.dart';
import 'package:fino/features/orders/presentation/pages/orders_page.dart';
import 'package:fino/ui/molecules/app_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/app_harness.dart';
import '../support/load_fonts.dart';
import '../support/nav_helpers.dart';
import '../support/seed_fino.dart';

/// The orders search field (pages stay mounted, hidden, with their state).
final Finder _search = find.descendant(
  of: find.byType(OrdersPage),
  matching: find.byType(TextField),
);
final Finder _fab = find.byType(AppFab);

Future<void> _typeSearch(WidgetTester tester, String text) async {
  await tester.enterText(_search, text);
  await tester.pumpAndSettle();
}

String _searchText(WidgetTester tester) =>
    tester.widget<TextField>(_search).controller!.text;

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
      for (final icon in [homeIcon, ordersIcon, inboxIcon, settingsIcon]) {
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
    await goTo(tester, ordersIcon);
    await _typeSearch(tester, 'café');

    await goTo(tester, homeIcon);
    await goTo(tester, ordersIcon);
    expect(_searchText(tester), 'café');
  });

  testWidgets('resizing bar ↔ rail keeps destination and state', (
    tester,
  ) async {
    await pumpFino(tester);
    await goTo(tester, ordersIcon);
    await _typeSearch(tester, 'café');

    await resizeTo(tester, const Size(1280, 800));
    expect(find.byType(NavigationRail), findsOneWidget);
    expect(_searchText(tester), 'café');

    await resizeTo(tester, const Size(390, 844));
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(_searchText(tester), 'café');
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

  testWidgets('leaving a destination and coming back lands on its root', (
    tester,
  ) async {
    await pumpFino(tester);
    await goTo(tester, settingsIcon);
    await tester.tap(find.text('Apariencia'));
    await tester.pumpAndSettle();

    await goTo(tester, homeIcon);
    await goTo(tester, settingsIcon);

    expect(find.byType(SettingsPage), findsOneWidget);
    expect(find.byType(AppearancePage), findsNothing);
    expect(find.byTooltip('Volver'), findsNothing);
  });

  group('primary action', () {
    testWidgets('opens a full-screen form above the navigation', (
      tester,
    ) async {
      await pumpFino(tester, seed: seedFino);
      await tester.tap(_fab);
      await tester.pumpAndSettle();

      expect(find.text('Nuevo pedido'), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);

      await tester.tap(find.byTooltip('Volver'));
      await tester.pumpAndSettle();
      expect(find.byType(NavigationBar), findsOneWidget);
    });

    testWidgets('only Inicio and Pedidos have one', (tester) async {
      await pumpFino(tester, seed: seedFino);
      expect(_fab, findsOneWidget);
      await goTo(tester, ordersIcon);
      expect(_fab, findsOneWidget);
      await goTo(tester, inboxIcon);
      expect(_fab, findsNothing);
      await goTo(tester, settingsIcon);
      expect(_fab, findsNothing);
    });

    testWidgets('without a team there is nothing to create yet', (
      tester,
    ) async {
      await pumpFino(tester);
      expect(_fab, findsNothing);
      expect(find.text('Empieza con tu equipo'), findsOneWidget);
    });

    testWidgets('floats at the bottom-end, icon only, on wide screens', (
      tester,
    ) async {
      const size = Size(1280, 800);
      await pumpFino(tester, size: size, seed: seedFino);
      expect(_fab, findsOneWidget);
      expect(find.text('Nuevo pedido'), findsNothing);
      expect(find.byType(FloatingActionButton), findsNothing);

      final rect = tester.getRect(_fab);
      expect(rect.bottom, greaterThan(size.height - 48));
      expect(rect.center.dx, greaterThan(size.width / 2));
      expect(rect.width, lessThanOrEqualTo(64));
    });

    testWidgets('floats over the content on tablets, icon only', (
      tester,
    ) async {
      const size = Size(700, 900);
      await pumpFino(tester, size: size, seed: seedFino);
      expect(_fab, findsOneWidget);
      expect(find.text('Nuevo pedido'), findsNothing);
      expect(tester.getRect(_fab).bottom, greaterThan(size.height - 48));
    });

    testWidgets('shows only its icon on compact screens', (tester) async {
      await pumpFino(tester, seed: seedFino);
      expect(find.text('Nuevo pedido'), findsNothing);
      expect(find.byTooltip('Nuevo pedido'), findsOneWidget);
    });
  });
}
