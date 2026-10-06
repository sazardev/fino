import 'package:fino/app/settings/settings_page.dart';
import 'package:fino/features/changelog/domain/changelog_note.dart';
import 'package:fino/features/changelog/domain/changelog_note_type.dart';
import 'package:fino/features/changelog/domain/changelog_release.dart';
import 'package:fino/features/changelog/presentation/pages/changelog_page.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/app_harness.dart';
import '../../support/fake_changelog_repository.dart';
import '../../support/load_fonts.dart';
import '../../support/nav_helpers.dart';

final _releases = [
  ChangelogRelease(
    version: '0.2.0',
    date: DateTime(2026, 10, 6),
    notes: const [
      ChangelogNote(
        type: ChangelogNoteType.feature,
        scope: 'auth',
        subject: 'Inicio de sesión con Google',
      ),
      ChangelogNote(type: ChangelogNoteType.fix, subject: 'Mantiene la sesión'),
    ],
  ),
  ChangelogRelease(version: '0.1.0', date: DateTime(2026, 10), notes: []),
];

Future<void> _openChangelog(WidgetTester tester) async {
  await goTo(tester, settingsIcon);
  await tester.tap(find.text('Novedades'));
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(loadGeistFonts);

  testWidgets('settings shows the current version and opens the history', (
    tester,
  ) async {
    await pumpFino(tester, changelog: FakeChangelogRepository(_releases));
    await goTo(tester, settingsIcon);
    expect(find.text('Versión 0.2.0'), findsOneWidget);

    await tester.tap(find.text('Novedades'));
    await tester.pumpAndSettle();

    expect(find.byType(ChangelogPage), findsOneWidget);
    expect(find.text('v0.2.0 · 6 oct 2026'), findsOneWidget);
    expect(find.text('Novedades'), findsOneWidget); // group label, not the tile
    expect(find.text('Correcciones'), findsOneWidget);
    expect(find.text('Mantiene la sesión'), findsOneWidget);
    expect(find.textContaining('Inicio de sesión con Google'), findsOneWidget);
    expect(find.byTooltip('Volver'), findsOneWidget);
  });

  testWidgets('a release with no user-facing notes says so', (tester) async {
    await pumpFino(tester, changelog: FakeChangelogRepository(_releases));
    await _openChangelog(tester);

    await tester.scrollUntilVisible(find.text('v0.1.0 · 1 oct 2026'), 200);
    expect(find.text('Mejoras internas y de estabilidad.'), findsOneWidget);
  });

  testWidgets('no releases yet: empty state, generic tile subtitle', (
    tester,
  ) async {
    await pumpFino(tester);
    await goTo(tester, settingsIcon);
    expect(find.text('Historial de versiones'), findsOneWidget);

    await tester.tap(find.text('Novedades'));
    await tester.pumpAndSettle();
    expect(find.text('Aún no hay versiones publicadas'), findsOneWidget);
  });

  testWidgets('a load failure shows an error state, not a crash', (
    tester,
  ) async {
    await pumpFino(
      tester,
      changelog: FakeChangelogRepository(const [], Exception('boom')),
    );
    await _openChangelog(tester);

    expect(find.text('No se pudo cargar el historial'), findsOneWidget);
  });

  testWidgets('the settings page is still the hub underneath', (tester) async {
    await pumpFino(tester);
    await goTo(tester, settingsIcon);
    expect(find.byType(SettingsPage), findsOneWidget);
  });
}
