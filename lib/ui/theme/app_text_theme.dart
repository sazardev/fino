import 'package:flutter/material.dart';

import '../design/app_font.dart';

/// Default Material 3 text theme (correctly colored from [scheme]) with only
/// the font family swapped to Geist.
///
/// Built from a real `ThemeData`, never straight from `Typography`: that
/// yields color-less styles and the text turns near-invisible.
TextTheme buildTextTheme(ColorScheme scheme) => ThemeData(
  useMaterial3: true,
  brightness: scheme.brightness,
  colorScheme: scheme,
).textTheme.apply(fontFamily: AppFont.sans);
