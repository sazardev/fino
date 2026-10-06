import 'package:flutter/services.dart';

/// Loads the real Geist fonts: the default test font (Ahem) is far wider and
/// reports overflows that don't exist.
Future<void> loadGeistFonts() async {
  for (final (family, files) in const [
    ('Geist', ['Regular', 'Medium', 'SemiBold', 'Bold']),
    ('GeistMono', ['Regular', 'Medium', 'SemiBold', 'Bold']),
  ]) {
    final loader = FontLoader(family);
    for (final weight in files) {
      loader.addFont(rootBundle.load('assets/fonts/$family-$weight.ttf'));
    }
    await loader.load();
  }
}
