import 'package:flutter/material.dart';

SwitchThemeData buildSwitchTheme(ColorScheme scheme) => SwitchThemeData(
  thumbColor: WidgetStateProperty.resolveWith(
    (states) => states.contains(WidgetState.selected) ? scheme.onPrimary : null,
  ),
  trackColor: WidgetStateProperty.resolveWith(
    (states) => states.contains(WidgetState.selected) ? scheme.primary : null,
  ),
);
