import 'package:flutter/material.dart';

import '../../ui/responsive/ui_size.dart';

String themeModeLabel(ThemeMode mode) => switch (mode) {
  ThemeMode.system => 'Sistema',
  ThemeMode.light => 'Claro',
  ThemeMode.dark => 'Oscuro',
};

String uiSizeLabel(UiSize size) => switch (size) {
  UiSize.small => 'S',
  UiSize.normal => 'M',
  UiSize.large => 'L',
  UiSize.extraLarge => 'XL',
};

/// What each interface size means, in a line.
String uiSizeHint(UiSize size) => switch (size) {
  UiSize.small => 'Compacto: más contenido en pantalla.',
  UiSize.normal => 'Estándar: el equilibrio de siempre.',
  UiSize.large => 'Cómodo: textos y botones más grandes.',
  UiSize.extraLarge => 'Muy grande: máxima legibilidad.',
};
