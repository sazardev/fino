/// The user's "interface size" choice: a multiplier on text, icons and
/// content widths.
enum UiSize {
  small(0.9),
  normal(1),
  large(1.25),
  extraLarge(1.5);

  new(this.multiplier);

  final double multiplier;
}
