import 'value_codec.dart';

/// Stores an enum by name.
class EnumCodec<T extends Enum> implements ValueCodec<T> {
  const new(this.values);

  final List<T> values;

  @override
  String encode(T value) => value.name;

  @override
  T? decode(String raw) {
    for (final value in values) {
      if (value.name == raw) return value;
    }
    return null;
  }
}
