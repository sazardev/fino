import 'package:fino/features/auth/domain/auth_user.dart';
import 'package:fino/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:fino/features/auth/presentation/widgets/profile_avatar.dart';
import 'package:fino/features/auth/presentation/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../support/fake_auth_repository.dart';
import '../../../support/load_fonts.dart';

void main() {
  setUpAll(loadGeistFonts);

  Future<void> pumpCard(WidgetTester tester, FakeAuthRepository auth) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [authRepositoryProvider.overrideWithValue(auth)],
        child: const MaterialApp(home: Scaffold(body: ProfileCard())),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('shows who is signed in', (tester) async {
    await pumpCard(tester, FakeAuthRepository(user: testUser));

    expect(find.text('Ana'), findsOneWidget);
    expect(find.text('ana@x.co'), findsOneWidget);
    expect(find.text('A'), findsOneWidget);
  });

  testWidgets('shows nothing when signed out', (tester) async {
    await pumpCard(tester, FakeAuthRepository());

    expect(find.byType(ProfileAvatar), findsNothing);
  });

  testWidgets('a name-less account still shows its email', (tester) async {
    await pumpCard(
      tester,
      FakeAuthRepository(
        user: const AuthUser(uid: 'u2', email: 'b@x.co'),
      ),
    );

    expect(find.text('b@x.co'), findsOneWidget);
    expect(find.text('B'), findsOneWidget);
  });

  testWidgets('the same user always gets the same avatar tone', (tester) async {
    Color toneOf(WidgetTester tester) => tester
        .widget<ColoredBox>(
          find.descendant(
            of: find.byType(ProfileAvatar),
            matching: find.byType(ColoredBox),
          ),
        )
        .color;

    await pumpCard(tester, FakeAuthRepository(user: testUser));
    final first = toneOf(tester);
    await pumpCard(tester, FakeAuthRepository(user: testUser));

    expect(toneOf(tester), first);
  });
}
