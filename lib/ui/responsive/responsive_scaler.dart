import 'package:fino/ui/responsive/ui_size_scope.dart' show UiSizeScope;
import 'package:flutter/widgets.dart';

import 'responsive.dart';

/// Scales text and icons for the screen and the user's UI size. Place it in
/// `MaterialApp.builder`, below [UiSizeScope].
class ResponsiveScaler extends StatelessWidget {
  const new({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final scale = Responsive.of(context).scale;
    final systemScale = media.textScaler.scale(14) / 14;

    return MediaQuery(
      data: media.copyWith(textScaler: TextScaler.linear(systemScale * scale)),
      child: IconTheme.merge(
        data: IconThemeData(size: 24 * scale),
        child: child,
      ),
    );
  }
}
