import 'value_codec.dart';

class BoolCodec implements ValueCodec<bool> {
  const BoolCodec();

  @override
  String encode(bool value) => value.toString();

  @override
  bool? decode(String raw) => switch (raw) {
    'true' => true,
    'false' => false,
    _ => null,
  };
}
