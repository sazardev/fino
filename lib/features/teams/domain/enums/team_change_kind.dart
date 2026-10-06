/// Qué hizo una acción de equipos: dice a la capa de datos cómo guardarla.
enum TeamChangeKind {
  /// Sin cambios (acción repetida).
  none,
  created,
  joined,
  inviteRegenerated,
  adminTransferred,
  membersRemoved,
  deleted,
  payoutMethodSet,
  profileUpdated,
}
