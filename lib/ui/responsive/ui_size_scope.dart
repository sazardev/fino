import 'package:flutter/widgets.dart';

import 'ui_size.dart';

/// Makes the user's interface-size choices available to layout code without
/// a global: the [UiSize] and whether big screens may grow it further.
class UiSizeScope extends InheritedWidget {
  const new({
    required this.size,
    required super.child,
    super.key,
    this.adaptToScreen = false,
  });

  final UiSize size;
  final bool adaptToScreen;

  /// The chosen size, or [UiSize.normal] when no scope is above.
  static UiSize of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<UiSizeScope>()?.size ??
      UiSize.normal;

  /// Whether big screens grow the interface beyond the chosen size.
  static bool adaptsToScreen(BuildContext context) =>
      context
          .dependOnInheritedWidgetOfExactType<UiSizeScope>()
          ?.adaptToScreen ??
      false;

  @override
  bool updateShouldNotify(UiSizeScope oldWidget) =>
      size != oldWidget.size || adaptToScreen != oldWidget.adaptToScreen;
}
