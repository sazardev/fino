import 'package:flutter/material.dart';

import '../design/app_font.dart';
import 'app_color_scheme.dart';
import 'app_text_theme.dart';
import 'components/card_component_theme.dart';
import 'components/filled_button_component_theme.dart';
import 'components/icon_button_component_theme.dart';
import 'components/input_decoration_component_theme.dart';
import 'components/list_tile_component_theme.dart';
import 'components/navigation_bar_component_theme.dart';
import 'components/navigation_rail_component_theme.dart';
import 'components/outlined_button_component_theme.dart';
import 'components/segmented_button_component_theme.dart';
import 'components/slider_component_theme.dart';
import 'components/switch_component_theme.dart';
import 'components/tooltip_component_theme.dart';

/// Flat, rounded Material 3 theme. Interactive feedback comes from
/// `BouncyTap`'s press-scale spring, not from the ink ripple.
abstract final class AppTheme {
  const new _();

  static ThemeData light(Color accent) => _build(accent, Brightness.light);

  static ThemeData dark(Color accent) => _build(accent, Brightness.dark);

  static ThemeData _build(Color accent, Brightness brightness) {
    final scheme = buildColorScheme(accent, brightness);
    final text = buildTextTheme(scheme);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      fontFamily: AppFont.sans,
      textTheme: text,
      scaffoldBackgroundColor: scheme.surface,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      cardTheme: buildCardTheme(scheme),
      listTileTheme: buildListTileTheme(scheme),
      navigationBarTheme: buildNavigationBarTheme(scheme, text),
      navigationRailTheme: buildNavigationRailTheme(scheme, text),
      switchTheme: buildSwitchTheme(scheme),
      iconButtonTheme: buildIconButtonTheme(),
      filledButtonTheme: buildFilledButtonTheme(text),
      outlinedButtonTheme: buildOutlinedButtonTheme(scheme),
      segmentedButtonTheme: buildSegmentedButtonTheme(),
      sliderTheme: buildSliderTheme(),
      tooltipTheme: buildTooltipTheme(scheme, text),
      inputDecorationTheme: buildInputDecorationTheme(scheme),
    );
  }
}
