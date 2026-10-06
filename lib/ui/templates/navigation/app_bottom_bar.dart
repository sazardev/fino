import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../atoms/chubby_icon.dart';
import '../../atoms/icon_pop.dart';
import '../../responsive/responsive.dart';
import 'app_destination.dart';

/// Bottom navigation for compact screens. The active icon pops each time the
/// selection changes. On a watch the labels are hidden.
class AppBottomBar extends StatelessWidget {
  const new({
    required this.destinations,
    required this.index,
    required this.onSelect,
    super.key,
  });

  final List<AppDestination> destinations;
  final int index;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final iconSize = (r.isWatch ? 20.0 : 24.0) * r.scale;

    return NavigationBar(
      selectedIndex: index,
      onDestinationSelected: onSelect,
      height: r.isWatch ? 56 : 80 * math.min(r.scale, 1.25),
      labelBehavior: r.isWatch
          ? NavigationDestinationLabelBehavior.alwaysHide
          : NavigationDestinationLabelBehavior.alwaysShow,
      destinations: [
        for (final d in destinations)
          NavigationDestination(
            label: d.label,
            tooltip: d.label,
            icon: ChubbyIcon(d.icon, size: iconSize),
            selectedIcon: IconPop(
              trigger: index,
              child: ChubbyIcon(d.icon, size: iconSize),
            ),
          ),
      ],
    );
  }
}
