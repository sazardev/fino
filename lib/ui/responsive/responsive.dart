import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import 'form_factor.dart';
import 'ui_size.dart';
import 'ui_size_scope.dart';

/// Everything layout code needs to adapt to the screen it is on.
///
/// Read with [Responsive.of]; it rebuilds the caller when the window size or
/// the user's [UiSize] changes.
///
/// The user's [UiSize] is honoured as chosen on every screen: "S" is S on a
/// phone, a tablet and a desktop. Only when `adaptToScreen` is on does a big
/// screen grow the interface further, up to 1.5×.
class Responsive {
  factory fromSize(
    Size size, {
    UiSize uiSize = UiSize.normal,
    bool adaptToScreen = false,
  }) {
    final shortest = size.shortestSide;
    final FormFactor factor;
    if (shortest < watchShortestSide) {
      factor = FormFactor.watch;
    } else if (size.width < 600) {
      factor = FormFactor.compact;
    } else if (size.width < 840) {
      factor = FormFactor.medium;
    } else {
      factor = FormFactor.expanded;
    }

    // Phones stay at 1.0; with [adaptToScreen], bigger screens grow gently.
    final base = factor == FormFactor.watch || !adaptToScreen
        ? 1.0
        : (shortest / 480).clamp(1.0, 1.5);
    return Responsive._(
      size: size,
      factor: factor,
      scale: base * uiSize.multiplier,
    );
  }
  factory of(BuildContext context) => Responsive.fromSize(
    MediaQuery.sizeOf(context),
    uiSize: UiSizeScope.of(context),
    adaptToScreen: UiSizeScope.adaptsToScreen(context),
  );

  const new _({required this.size, required this.factor, required this.scale});

  final Size size;
  final FormFactor factor;

  /// Multiplier for text, icons and content widths.
  final double scale;

  /// Below this shortest side the screen is treated as a watch.
  static const double watchShortestSide = 260;

  bool get isWatch => factor == FormFactor.watch;
  bool get isLandscape => size.width > size.height;
  bool get isExpanded => factor == FormFactor.expanded;

  /// Primary navigation goes in a side rail instead of the bottom bar.
  bool get usesSideNavigation =>
      factor == FormFactor.medium || factor == FormFactor.expanded;

  /// Side-by-side layout: room for content plus a control panel.
  bool get isWide => !isWatch && size.width >= 600 && size.aspectRatio > 1.15;

  /// Readable content column width for forms and lists.
  double get contentWidth {
    if (isWatch) return double.infinity;
    final base = switch (factor) {
      FormFactor.compact => 480.0,
      FormFactor.medium => 620.0,
      _ => 720.0,
    };
    return math.min(base * scale, size.width);
  }

  /// Horizontal page padding.
  double get pagePadding => isWatch ? 10 : (20 * math.min(scale, 1.3));
}
