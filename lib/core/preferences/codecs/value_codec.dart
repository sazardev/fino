/// Turns a value into a string for storage and back.
abstract interface class ValueCodec<T> {
  String encode(T value);

  /// The stored value, or null when [raw] is not valid (falls back to the
  /// default).
  T? decode(String raw);
}
