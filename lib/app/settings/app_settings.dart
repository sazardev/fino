import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/preferences/codecs/bool_codec.dart';
import '../../core/preferences/codecs/color_codec.dart';
import '../../core/preferences/codecs/enum_codec.dart';
import '../../core/preferences/persisted_value.dart';
import '../../ui/responsive/ui_size.dart';
import '../../ui/theme/accent_palette.dart';

/// Every user-customizable look-and-feel setting. Each one is listenable and
/// persisted; changes apply live.
class AppSettings {
  new(SharedPreferences prefs)
    : accent = PersistedValue(
        prefs: prefs,
        key: 'accent_color',
        initial: AccentPalette.defaultAccent,
        codec: const ColorCodec(),
      ),
      themeMode = PersistedValue(
        prefs: prefs,
        key: 'theme_mode',
        initial: ThemeMode.system,
        codec: const EnumCodec(ThemeMode.values),
      ),
      uiSize = PersistedValue(
        prefs: prefs,
        key: 'ui_size',
        initial: UiSize.normal,
        codec: const EnumCodec(UiSize.values),
      ),
      adaptToScreen = PersistedValue(
        prefs: prefs,
        key: 'adapt_to_screen',
        initial: false,
        codec: const BoolCodec(),
      ),
      hapticsEnabled = PersistedValue(
        prefs: prefs,
        key: 'haptics_enabled',
        initial: true,
        codec: const BoolCodec(),
      );

  final PersistedValue<Color> accent;
  final PersistedValue<ThemeMode> themeMode;
  final PersistedValue<UiSize> uiSize;

  /// Lets big screens (tablet, desktop, web) grow the interface beyond
  /// [uiSize]. Off by default: the chosen size means the same everywhere.
  final PersistedValue<bool> adaptToScreen;
  final PersistedValue<bool> hapticsEnabled;

  static Future<AppSettings> load() async =>
      AppSettings(await SharedPreferences.getInstance());

  /// Changes that must rebuild the whole `MaterialApp`.
  Listenable get appearance =>
      Listenable.merge([accent, themeMode, uiSize, adaptToScreen]);

  /// Puts theme, accent and interface size back to their defaults.
  Future<void> resetAppearance() => Future.wait([
    accent.update(AccentPalette.defaultAccent),
    themeMode.update(ThemeMode.system),
    uiSize.update(UiSize.normal),
    adaptToScreen.update(false),
  ]);
}
