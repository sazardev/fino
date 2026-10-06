/// Quién puede ver el método de cobro de alguien (SPEC M4).
abstract final class PayoutMethodAccess {
  /// Solo su dueño, o quien tiene una deuda viva con él. Nadie más, ni
  /// siquiera el admin.
  static bool canView({
    required String viewerId,
    required String ownerId,
    required bool viewerHasLiveDebtToOwner,
  }) => viewerId == ownerId || viewerHasLiveDebtToOwner;
}
