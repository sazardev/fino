import 'dart:math';

/// Genera un código de invitación nuevo cada vez que se invoca.
typedef InviteCodeGenerator = String Function();

/// Reglas del código de invitación (SPEC E2–E3).
abstract final class InviteCodes {
  /// Sin caracteres que se confunden (0/O, 1/I/L).
  static const alphabet = 'ABCDEFGHJKMNPQRSTUVWXYZ23456789';
  static const length = 8;

  static String generate(Random random) => String.fromCharCodes([
    for (var i = 0; i < length; i++)
      alphabet.codeUnitAt(random.nextInt(alphabet.length)),
  ]);

  /// Lo que se compara: sin espacios ni guiones y en mayúsculas.
  static String normalize(String raw) =>
      raw.replaceAll(RegExp(r'[\s-]'), '').toUpperCase();
}
