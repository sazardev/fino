import 'package:fino/app/settings/settings_page.dart';
import 'package:fino/features/auth/domain/auth_user.dart';
import 'package:fino/features/auth/presentation/widgets/profile_card.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/app_harness.dart';
import '../../support/fake_auth_repository.dart';
import '../../support/load_fonts.dart';
import '../../support/nav_helpers.dart';

void main() {
  setUpAll(loadGeistFonts);

  testWidgets('settings opens with who is signed in', (tester) async {
    await pumpFino(
      tester,
      auth: FakeAuthRepository(
        user: const AuthUser(
          uid: 'u7',
          displayName: 'Omar Reyes',
          email: 'omar@x.co',
        ),
      ),
    );
    await goTo(tester, settingsIcon);

    expect(find.byType(SettingsPage), findsOneWidget);
    expect(find.byType(ProfileCard), findsOneWidget);
    expect(find.text('Omar Reyes'), findsOneWidget);
    expect(find.text('omar@x.co'), findsOneWidget);
    expect(find.text('OR'), findsOneWidget);
  });
}
