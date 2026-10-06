import 'dart:convert';

import 'package:fino/features/auth/data/fake_google_identity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('the ID token carries the claims the emulator reads', () {
    const identity = FakeGoogleIdentity(
      subject: 's1',
      email: 'a@b.co',
      name: 'Ana',
    );

    expect(jsonDecode(identity.idToken), {
      'sub': 's1',
      'email': 'a@b.co',
      'email_verified': true,
      'name': 'Ana',
    });
  });
}
