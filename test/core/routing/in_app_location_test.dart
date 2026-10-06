import 'package:fino/core/routing/in_app_location.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('keeps in-app locations', () {
    expect(inAppLocationOrNull('/ajustes'), '/ajustes');
    expect(inAppLocationOrNull('/ajustes?x=1'), '/ajustes?x=1');
  });

  test('rejects anything that could leave the app', () {
    for (final raw in [null, '', 'ajustes', '//evil.com', 'https://evil.com']) {
      expect(inAppLocationOrNull(raw), isNull, reason: '$raw');
    }
  });
}
