import 'dart:ui';

import 'value_codec.dart';

/// Stores a [Color] as its ARGB integer.
class ColorCodec implements ValueCodec<Color> {
  const ColorCodec();

  @override
  String encode(Color value) => value.toARGB32().toString();

  @override
  Color? decode(String raw) {
    final argb = int.tryParse(raw);
    return argb == null ? null : Color(argb);
  }
}
