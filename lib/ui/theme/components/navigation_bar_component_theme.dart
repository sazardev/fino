import 'package:flutter/material.dart';

/// Flat bottom bar: no elevation or tint, a `primary` pill behind the active
/// icon and a bolder active label.
NavigationBarThemeData buildNavigationBarTheme(
  ColorScheme scheme,
  TextTheme text,
) => NavigationBarThemeData(
  elevation: 0,
  shadowColor: Colors.transparent,
  surfaceTintColor: Colors.transparent,
  backgroundColor: scheme.surfaceContainer,
  indicatorColor: scheme.primary,
  indicatorShape: const StadiumBorder(),
  overlayColor: const WidgetStatePropertyAll(Colors.transparent),
  iconTheme: WidgetStateProperty.resolveWith(
    (states) => IconThemeData(
      color: states.contains(WidgetState.selected)
          ? scheme.onPrimary
          : scheme.onSurfaceVariant,
    ),
  ),
  labelTextStyle: WidgetStateProperty.resolveWith((states) {
    final selected = states.contains(WidgetState.selected);
    return text.labelMedium?.copyWith(
      fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
      color: selected ? scheme.onSurface : scheme.onSurfaceVariant,
    );
  }),
);
