import 'package:flutter/material.dart';

import '../../design/app_radii.dart';

SegmentedButtonThemeData buildSegmentedButtonTheme() =>
    SegmentedButtonThemeData(
      style: SegmentedButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: AppRadii.smRadius),
      ),
    );
