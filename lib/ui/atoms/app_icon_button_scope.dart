import 'package:flutter/widgets.dart';

/// Lets a toolbar dictate the diameter of every `AppIconButton` below it
/// (buttons with an explicit `size` keep theirs).
class AppIconButtonScope extends InheritedWidget {
  const AppIconButtonScope({
    super.key,
    required this.size,
    required super.child,
  });

  final double size;

  static double? sizeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppIconButtonScope>()?.size;

  @override
  bool updateShouldNotify(AppIconButtonScope old) => size != old.size;
}
