import 'package:flutter/widgets.dart';

import 'responsive.dart';

/// Width constraints for content columns.
abstract final class AppLayout {
  const AppLayout._();

  /// Readable column that grows with the screen.
  static double contentWidth(BuildContext context) =>
      Responsive.of(context).contentWidth;

  /// Wider column for dense screens on large displays.
  static double wideContentWidth(BuildContext context) {
    final r = Responsive.of(context);
    return r.isExpanded ? r.size.width * 0.9 : r.contentWidth;
  }
}
