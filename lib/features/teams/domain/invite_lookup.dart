import 'entities/invite_info.dart';

/// Busca un código de invitación en el servidor: entrar a un equipo es lo
/// único que no funciona sin conexión.
abstract interface class InviteLookup {
  /// `null` si el código no existe (o ya no sirve).
  Future<InviteInfo?> find(String code);
}
