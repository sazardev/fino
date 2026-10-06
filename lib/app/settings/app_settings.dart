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
      hapticsEnabled = PersistedValue(
        prefs: prefs,
        key: 'haptics_enabled',
        initial: true,
        codec: const BoolCodec(),
      );

  final PersistedValue<Color> accent;
  final PersistedValue<ThemeMode> themeMode;
  final PersistedValue<UiSize> uiSize;
  final PersistedValue<bool> hapticsEnabled;

  static Future<AppSettings> load() async =>
      AppSettings(await SharedPreferences.getInstance());

  /// Changes that must rebuild the whole `MaterialApp`.
  Listenable get appearance => Listenable.merge([accent, themeMode, uiSize]);
}
