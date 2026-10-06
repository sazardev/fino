import 'package:flutter/material.dart';

import '../../design/app_radii.dart';

ListTileThemeData buildListTileTheme(ColorScheme scheme) => ListTileThemeData(
  iconColor: scheme.primary,
  shape: const RoundedRectangleBorder(borderRadius: AppRadii.mdRadius),
);
