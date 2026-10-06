import 'package:flutter/material.dart';

/// Black or white, whichever reads better on [background].
Color foregroundOn(Color background) =>
    ThemeData.estimateBrightnessForColor(background) == Brightness.dark
    ? Colors.white
    : Colors.black;
