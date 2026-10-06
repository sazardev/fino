import 'package:flutter/material.dart';

import '../../atoms/chubby_icon.dart';
import '../../atoms/icon_pop.dart';
import '../../responsive/responsive.dart';
import 'app_destination.dart';
import 'destination_badge.dart';

/// Navigation for medium and expanded screens: a compact rail (label under
/// the icon) that widens into an extended one (label beside it). Same
/// destinations, icons and pill as the bottom bar.
class AppSideRail extends StatelessWidget {
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
    final extended = r.isExpanded;
    final iconSize = 24.0 * r.scale;

    return SafeArea(
      right: false,
      child: NavigationRail(
        selectedIndex: index,
        onDestinationSelected: onSelect,
        extended: extended,
        labelType: extended
            ? NavigationRailLabelType.none
            : NavigationRailLabelType.all,
        destinations: [
          for (final d in destinations)
            NavigationRailDestination(
              label: Text(d.label),
              icon: DestinationBadge(
                count: d.badge,
                child: ChubbyIcon(d.icon, size: iconSize),
              ),
              selectedIcon: IconPop(
                trigger: index,
                child: DestinationBadge(
                  count: d.badge,
                  child: ChubbyIcon(d.icon, size: iconSize),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
