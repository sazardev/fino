import 'package:fino/app/gallery/gallery_page.dart';
import 'package:fino/app/home/home_page.dart';
import 'package:fino/app/settings/appearance_page.dart';
import 'package:fino/app/settings/settings_page.dart';
import 'package:fino/ui/atoms/accent_swatch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/app_harness.dart';
import '../support/load_fonts.dart';

void main() {
  setUpAll(loadGeistFonts);

  testWidgets('splash leads to the home screen', (tester) async {
    await pumpFino(tester);
    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('settings → appearance changes the theme live', (tester) async {
    final settings = await pumpFino(tester);

    await tester.tap(find.byTooltip('Ajustes'));
    await tester.pumpAndSettle();
    expect(find.byType(SettingsPage), findsOneWidget);

    await tester.tap(find.text('Apariencia'));
    await tester.pumpAndSettle();
    expect(find.byType(AppearancePage), findsOneWidget);

    await tester.tap(find.text('Oscuro'));
    await tester.pumpAndSettle();
    expect(settings.themeMode.value, ThemeMode.dark);
    expect(
      Theme.of(tester.element(find.byType(AppearancePage))).brightness,
      Brightness.dark,
    );

    await tester.tap(find.byType(AccentSwatch).first);
    await tester.pumpAndSettle();
    expect(settings.accent.value, Colors.red);
  });

  testWidgets('the custom color panel opens inline', (tester) async {
    await pumpFino(tester);
    await tester.tap(find.byTooltip('Ajustes'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Apariencia'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.colorize_rounded));
    await tester.pumpAndSettle();

    expect(find.text('Tono'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('destructive rows confirm in place, no dialog', (tester) async {
    await pumpFino(tester);
    await tester.tap(find.byTooltip('Ajustes'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Componentes'));
    await tester.pumpAndSettle();
    expect(find.byType(GalleryPage), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Borrar ejemplo'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Borrar ejemplo'));
    await tester.pumpAndSettle();

    expect(find.text('Confirmar: borrar ejemplo'), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);

    await tester.tap(find.text('Cancelar'));
    await tester.pumpAndSettle();
    expect(find.text('Confirmar: borrar ejemplo'), findsNothing);
  });
}
