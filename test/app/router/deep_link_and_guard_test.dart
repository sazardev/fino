import 'package:fino/app/settings/appearance_page.dart';
import 'package:fino/core/analytics/events/screen_viewed.dart';
import 'package:fino/features/auth/presentation/pages/sign_in_page.dart';
import 'package:fino/features/auth/presentation/widgets/google_sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/app_harness.dart';
import '../../support/fake_auth_repository.dart';
import '../../support/load_fonts.dart';
import '../../support/recording_analytics_service.dart';

void main() {
  setUpAll(loadGeistFonts);

  testWidgets('a deep link opens its screen inside the frame', (tester) async {
    await pumpFino(tester, initialLocation: '/ajustes/apariencia');

    expect(find.byType(AppearancePage), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
  });

  testWidgets('signed out, every route lands on sign-in', (tester) async {
    await pumpFino(tester, auth: FakeAuthRepository());

    expect(find.byType(SignInPage), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
  });

  testWidgets('signing in returns to the deep link that was asked for', (
    tester,
  ) async {
    await pumpFino(
      tester,
      auth: FakeAuthRepository(),
      initialLocation: '/ajustes/apariencia',
    );
    expect(find.byType(SignInPage), findsOneWidget);

    await tester.tap(find.byType(GoogleSignInButton));
    await tester.pumpAndSettle();

    expect(find.byType(AppearancePage), findsOneWidget);
  });

  testWidgets('a failed sign-in says so and stays put', (tester) async {
    await pumpFino(
      tester,
      auth: FakeAuthRepository()..signInError = Exception('cancelled'),
    );

    await tester.tap(find.byType(GoogleSignInButton));
    await tester.pumpAndSettle();

    expect(find.byType(SignInPage), findsOneWidget);
    expect(find.textContaining('No pudimos'), findsOneWidget);
  });

  testWidgets('screen views are reported once per path', (tester) async {
    final analytics = RecordingAnalyticsService();
    await pumpFino(tester, analytics: analytics);

    final screens = analytics.events.whereType<ScreenViewed>().map(
      (e) => e.screen,
    );
    expect(screens, ['/']);
  });
}
