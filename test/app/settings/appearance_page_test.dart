import 'package:fino/app/settings/app_settings.dart';
import 'package:fino/app/settings/appearance_page.dart';
import 'package:fino/app/settings/settings_scope.dart';
import 'package:fino/ui/atoms/accent_swatch.dart';
import 'package:fino/ui/molecules/preset_tile.dart';
import 'package:fino/ui/responsive/ui_size.dart';
import 'package:fino/ui/theme/accent_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late AppSettings settings;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    settings = AppSettings(await SharedPreferences.getInstance());
  });

  Future<void> pumpPage(WidgetTester tester, {Size? size}) async {
    tester.view.physicalSize = size ?? const Size(390, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      SettingsScope(
        settings: settings,
        child: const MaterialApp(home: AppearancePage()),
      ),
    );
    await tester.pumpAndSettle();
  }

  Finder preset(String label) =>
      find.descendant(of: find.byType(PresetTile), matching: find.text(label));

  testWidgets('a look sets theme and color, and leaves the size alone', (
    tester,
  ) async {
    await settings.uiSize.update(UiSize.small);
    await pumpPage(tester);

    await tester.tap(preset('Medianoche'));
    await tester.pumpAndSettle();
    expect(settings.themeMode.value, ThemeMode.dark);
    expect(settings.accent.value, AccentPalette.violet);
    expect(settings.uiSize.value, UiSize.small);

    await tester.tap(preset('Océano'));
    await tester.pumpAndSettle();
    expect(settings.themeMode.value, ThemeMode.light);
    expect(settings.accent.value, AccentPalette.royalBlue);
  });

  testWidgets('looks are a vertical list on a phone', (tester) async {
    await pumpPage(tester);

    final tops = [
      for (final t in tester.widgetList(find.byType(PresetTile)))
        tester.getTopLeft(find.byWidget(t)),
    ];
    expect(tops, hasLength(6));
    expect({for (final t in tops) t.dx}, hasLength(1));
    expect({for (final t in tops) t.dy}, hasLength(6));
  });

  testWidgets('looks go two per row when there is room', (tester) async {
    await pumpPage(tester, size: const Size(1000, 2400));

    final lefts = {
      for (final t in tester.widgetList(find.byType(PresetTile)))
        tester.getTopLeft(find.byWidget(t)).dx,
    };
    expect(lefts, hasLength(2));
  });

  testWidgets('the section shows "Personalizado" once nothing matches', (
    tester,
  ) async {
    await settings.accent.update(const Color(0xFF123456));
    await pumpPage(tester);
    await tester.tap(find.text('Estilo rápido'));
    await tester.pumpAndSettle();

    expect(find.text('Personalizado'), findsOneWidget);
  });

  testWidgets('a folded section shows its value; tapping unfolds it', (
    tester,
  ) async {
    await pumpPage(tester);
    // Folded sections still say what they are set to.
    expect(find.text('Sistema'), findsOneWidget);
    expect(find.text('M'), findsOneWidget);

    await tester.tap(find.text('Tema'));
    await tester.pumpAndSettle();
    expect(find.text('Claro'), findsOneWidget);
    expect(
      find.textContaining('Sistema sigue el modo claro u oscuro'),
      findsOneWidget,
    );
  });

  testWidgets('tapping the custom swatch again folds its panel', (
    tester,
  ) async {
    await pumpPage(tester);

    await tester.tap(find.byIcon(Icons.colorize_rounded));
    await tester.pumpAndSettle();
    expect(find.text('Tono'), findsOneWidget);
    final custom = settings.accent.value;

    await tester.tap(find.byType(AccentSwatch).last);
    await tester.pumpAndSettle();
    expect(find.text('Tono'), findsNothing);
    expect(settings.accent.value, custom);
  });

  testWidgets('the size section explains the choice and offers to adapt', (
    tester,
  ) async {
    await pumpPage(tester);
    await tester.tap(find.text('Tamaño de la interfaz'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Es el mismo en móvil, tablet y web'), findsOne);
    expect(settings.adaptToScreen.value, isFalse);

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    expect(settings.adaptToScreen.value, isTrue);
    await tester.tap(find.text('Tamaño de la interfaz'));
    await tester.pumpAndSettle();
    expect(find.text('M · Adaptable'), findsOneWidget);
  });

  testWidgets('restoring needs a confirmation, then resets everything', (
    tester,
  ) async {
    await settings.themeMode.update(ThemeMode.dark);
    await settings.uiSize.update(UiSize.large);
    await settings.adaptToScreen.update(true);
    await settings.accent.update(AccentPalette.rose);
    await pumpPage(tester);

    await tester.tap(find.text('Restablecer apariencia'));
    await tester.pumpAndSettle();
    expect(settings.uiSize.value, UiSize.large, reason: 'not yet confirmed');

    await tester.tap(find.text('Confirmar: restablecer'));
    await tester.pumpAndSettle();
    expect(settings.themeMode.value, ThemeMode.system);
    expect(settings.uiSize.value, UiSize.normal);
    expect(settings.adaptToScreen.value, isFalse);
    expect(settings.accent.value, AccentPalette.defaultAccent);
  });
}
