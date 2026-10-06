import 'package:flutter/material.dart';

TooltipThemeData buildTooltipTheme(ColorScheme scheme, TextTheme text) =>
    TooltipThemeData(
      decoration: BoxDecoration(
        color: scheme.inverseSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: text.bodySmall?.copyWith(color: scheme.onInverseSurface),
    );
