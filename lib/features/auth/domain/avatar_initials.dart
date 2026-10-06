import 'auth_user.dart';

/// The letters shown in a generated avatar (SPEC U3).
abstract final class AvatarInitials {
  const new _();

  /// First letters of the first two words of the name, or of the first two
  /// words of the email's local part when there is no name; `?` when there is
  /// neither.
  static String of(AuthUser user) {
    final name = user.displayName?.trim();
    final source = (name == null || name.isEmpty)
        ? user.email?.split('@').first.trim()
        : name;
    if (source == null || source.isEmpty) return '?';

    final words = source.split(RegExp(r'[\s._-]+')).where((w) => w.isNotEmpty);
    return words.take(2).map((w) => w[0].toUpperCase()).join();
  }
}
