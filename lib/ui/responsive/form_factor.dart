/// Coarse screen class, decided from the logical window size alone.
enum FormFactor {
  /// Wearables: ~200 dp.
  watch,

  /// Phones in portrait.
  compact,

  /// Large phones sideways, small tablets, small desktop windows.
  medium,

  /// Tablets, desktop, TV.
  expanded,
}
