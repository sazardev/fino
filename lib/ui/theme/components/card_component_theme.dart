import 'package:flutter/material.dart';

import '../../design/app_radii.dart';

CardThemeData buildCardTheme(ColorScheme scheme) => CardThemeData(
  elevation: 0,
  shadowColor: Colors.transparent,
  surfaceTintColor: Colors.transparent,
  color: scheme.surfaceContainerHigh,
  shape: const RoundedRectangleBorder(borderRadius: AppRadii.lgRadius),
);
