import 'package:flutter/material.dart';

import '../../design/app_radii.dart';

FilledButtonThemeData buildFilledButtonTheme(TextTheme text) =>
    FilledButtonThemeData(
      style: FilledButton.styleFrom(
        elevation: 0,
        shape: AppRadii.pill,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        textStyle: text.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
        ),
      ),
    );
