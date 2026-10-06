import 'package:fino/features/auth/domain/auth_user.dart';
import 'package:fino/features/auth/domain/avatar_initials.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String initials({String? name, String? email}) =>
      AvatarInitials.of(AuthUser(uid: 'u', displayName: name, email: email));

  test('uses the first letters of the first two words of the name', () {
    expect(initials(name: 'Omar Reyes Díaz'), 'OR');
    expect(initials(name: '  ana  '), 'A');
  });

  test('falls back to the email when there is no name', () {
    expect(initials(email: 'ana.lopez@x.co'), 'AL');
    expect(initials(name: ' ', email: 'beto@x.co'), 'B');
  });

  test('is a question mark when there is nothing to go on', () {
    expect(initials(), '?');
  });
}
