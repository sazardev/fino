import 'package:flutter/material.dart';

AppBarThemeData buildAppBarTheme(TextTheme text) => AppBarThemeData(
  backgroundColor: Colors.transparent,
  surfaceTintColor: Colors.transparent,
  shadowColor: Colors.transparent,
  elevation: 0,
  centerTitle: false,
  titleTextStyle: text.titleMedium?.copyWith(
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  ),
);
