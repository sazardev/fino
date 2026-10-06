import 'package:flutter/material.dart';

/// Side rail with the same look as the bottom bar: flat, `primary` pill.
NavigationRailThemeData buildNavigationRailTheme(
  ColorScheme scheme,
  TextTheme text,
) => NavigationRailThemeData(
  elevation: 0,
  backgroundColor: scheme.surfaceContainer,
  useIndicator: true,
  indicatorColor: scheme.primary,
  indicatorShape: const StadiumBorder(),
  selectedIconTheme: IconThemeData(color: scheme.onPrimary),
  unselectedIconTheme: IconThemeData(color: scheme.onSurfaceVariant),
  selectedLabelTextStyle: text.labelMedium?.copyWith(
    fontWeight: FontWeight.w600,
    color: scheme.onSurface,
  ),
  unselectedLabelTextStyle: text.labelMedium?.copyWith(
    fontWeight: FontWeight.w500,
    color: scheme.onSurfaceVariant,
  ),
);
