import 'dart:convert';

/// A made-up Google identity. The Auth emulator accepts it as an ID token
/// without verifying it, so development never needs a real Google account.
class FakeGoogleIdentity {
  const new({
    this.subject = 'dev-user',
    this.email = 'dev@fino.test',
    this.name = 'Dev Fino',
  });

  final String subject;
  final String email;
  final String name;

  String get idToken => jsonEncode({
    'sub': subject,
    'email': email,
    'email_verified': true,
    'name': name,
  });
}
