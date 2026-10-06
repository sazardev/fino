import 'package:flutter/material.dart';

import '../../design/app_curves.dart';
import '../../design/app_durations.dart';
import '../../responsive/responsive.dart';

/// Floats the screen's primary action at the bottom-end corner of the
/// content column, over the page. It scales and fades in and out as the
/// action appears or goes away with the destination.
class AppFabSlot extends StatelessWidget {
  const new({required this.fab, super.key});

  final Widget? fab;

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    return SafeArea(
      top: false,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: r.contentWidth),
          child: Padding(
            padding: EdgeInsets.all(r.pagePadding),
            child: Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: AnimatedSwitcher(
                duration: AppDurations.medium,
                switchInCurve: AppCurves.emphasized,
                switchOutCurve: AppCurves.select,
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(scale: animation, child: child),
                ),
                child: fab ?? const SizedBox.shrink(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
