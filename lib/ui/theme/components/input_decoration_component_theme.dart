import 'package:flutter/material.dart';

import '../../design/app_radii.dart';

/// Text fields: filled tonal surface, rounded, no outline.
InputDecorationThemeData buildInputDecorationTheme(ColorScheme scheme) {
  const shape = OutlineInputBorder(
    borderRadius: AppRadii.smRadius,
    borderSide: BorderSide.none,
  );
  return InputDecorationThemeData(
    filled: true,
    fillColor: scheme.surfaceContainerHigh,
    border: shape,
    enabledBorder: shape,
    focusedBorder: shape.copyWith(
      borderSide: BorderSide(color: scheme.primary, width: 2),
    ),
  );
}
