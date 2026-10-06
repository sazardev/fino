import 'package:flutter/material.dart';

import '../atoms/app_icon_button_scope.dart';
import '../atoms/pop_in.dart';
import 'action_bar_metrics.dart';

/// Just the buttons, no surface behind them: a row or column of icon buttons
/// that pop in one after another.
class ActionBar extends StatelessWidget {
  const ActionBar({
    super.key,
    required this.items,
    required this.vertical,
    required this.size,
  });

  final List<Widget> items;
  final bool vertical;

  /// Diameter given to every button.
  final double size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kActionPad),
      // Safety net: shrink the bar instead of overflowing.
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: AppIconButtonScope(
          size: size,
          child: Flex(
            direction: vertical ? Axis.vertical : Axis.horizontal,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < items.length; i++) ...[
                if (i > 0)
                  const SizedBox(width: kActionGap, height: kActionGap),
                PopIn(
                  delay: Duration(milliseconds: 60 * i),
                  child: items[i],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
