/// Por qué una regla de equipos rechazó una acción.
enum TeamFailureReason {
  invalidName,
  invalidInviteCode,
  notMember,
  notAdmin,
  targetNotMember,
  cannotTargetSelf,
  adminMustTransfer,
  adminMustDeleteTeam,
  hasLiveDebts,
  invalidClabe,
  invalidCard,
  bankRequired,
}
