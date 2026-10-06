import 'package:flutter/material.dart';

import '../../design/app_radii.dart';

/// Flat: a tonal fill instead of an outline.
OutlinedButtonThemeData buildOutlinedButtonTheme(ColorScheme scheme) =>
    OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: AppRadii.pill,
        side: BorderSide.none,
        backgroundColor: scheme.surfaceContainerHigh,
      ),
    );
