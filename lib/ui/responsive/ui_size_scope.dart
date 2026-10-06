import 'package:flutter/widgets.dart';

import 'ui_size.dart';

/// Makes the user's [UiSize] available to layout code without a global.
class UiSizeScope extends InheritedWidget {
  const new({required this.size, required super.child, super.key});

  final UiSize size;

  /// The chosen size, or [UiSize.normal] when no scope is above.
  static UiSize of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<UiSizeScope>()?.size ??
      UiSize.normal;

  @override
  bool updateShouldNotify(UiSizeScope oldWidget) => size != oldWidget.size;
}
