/// Raw vibration primitives. Implement to swap the platform (or to fake it in
/// tests); app code never calls this directly, only through `Haptics`.
abstract interface class HapticEngine {
  void light();
  void medium();
  void heavy();
  void selection();
}
