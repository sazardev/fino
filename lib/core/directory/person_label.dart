import 'directory_person.dart';

/// Cómo se nombra a alguien en pantalla: "Tú" si soy yo, su nombre si lo
/// conozco y "Alguien" si aún no bajó su perfil.
abstract final class PersonLabel {
  static String of(
    Map<String, DirectoryPerson> people, {
    required String teamId,
    required String userId,
    required String? me,
  }) {
    if (userId == me) return 'Tú';
    return people[DirectoryPerson.keyOf(teamId, userId)]?.displayName ??
        'Alguien';
  }

  /// Solo el primer nombre ("Ana García" → "Ana").
  static String first(String name) => name.trim().split(RegExp(r'\s+')).first;
}
