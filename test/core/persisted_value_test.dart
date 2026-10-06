import 'package:fino/app/settings/app_settings.dart';
import 'package:fino/ui/responsive/ui_size.dart';
import 'package:fino/ui/theme/accent_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<AppSettings> _load(Map<String, Object> stored) async {
  SharedPreferences.setMockInitialValues(stored);
  return AppSettings(await SharedPreferences.getInstance());
}

void main() {
  test('defaults when nothing is stored', () async {
    final s = await _load({});
    expect(s.accent.value, AccentPalette.defaultAccent);
    expect(s.themeMode.value, ThemeMode.system);
    expect(s.uiSize.value, UiSize.normal);
    expect(s.hapticsEnabled.value, isTrue);
  });

  test('updates apply immediately and survive a reload', () async {
    final s = await _load({});
    await s.accent.update(const Color(0xFF123456));
    await s.themeMode.update(ThemeMode.dark);
    await s.uiSize.update(UiSize.large);
    await s.hapticsEnabled.update(false);

    expect(s.themeMode.value, ThemeMode.dark);

    final again = AppSettings(await SharedPreferences.getInstance());
    expect(again.accent.value, const Color(0xFF123456));
    expect(again.themeMode.value, ThemeMode.dark);
    expect(again.uiSize.value, UiSize.large);
    expect(again.hapticsEnabled.value, isFalse);
  });

  test('garbage in storage falls back to the default', () async {
    final s = await _load({
      'accent_color': 'nope',
      'theme_mode': 'sepia',
      'ui_size': '',
      'haptics_enabled': 'maybe',
    });
    expect(s.accent.value, AccentPalette.defaultAccent);
    expect(s.themeMode.value, ThemeMode.system);
    expect(s.uiSize.value, UiSize.normal);
    expect(s.hapticsEnabled.value, isTrue);
  });

  test('palette is a short curated list and the default is part of it', () {
    expect(AccentPalette.colors, hasLength(5));
    expect(AccentPalette.colors, contains(AccentPalette.defaultAccent));
  });
}
