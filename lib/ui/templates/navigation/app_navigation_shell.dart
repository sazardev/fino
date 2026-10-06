import 'package:flutter/material.dart';

import '../../../core/haptics/haptics.dart';
import '../../organisms/fade_scale_indexed_stack.dart';
import '../../responsive/responsive.dart';
import 'app_bottom_bar.dart';
import 'app_destination.dart';
import 'app_side_rail.dart';

/// The app's frame: primary navigation plus the active destination's page.
///
/// Chosen by window width, never by platform: a bottom bar when compact, a
/// side rail when medium or expanded. Pages stay alive across destination
/// switches *and* across the bar ↔ rail change (resizing a web window or
/// rotating a tablet loses nothing).
class AppNavigationShell extends StatefulWidget {
  const AppNavigationShell({
    super.key,
    required this.destinations,
    required this.pages,
    required this.index,
    required this.onSelect,
    this.onReselect,
    this.fab,
  }) : assert(destinations.length == pages.length);

  final List<AppDestination> destinations;

  /// One page per destination, in the same order.
  final List<Widget> pages;
  final int index;
  final ValueChanged<int> onSelect;

  /// Called when the active destination is tapped again.
  final ValueChanged<int>? onReselect;

  /// The screen's one primary action: floats over the bar, or sits atop the
  /// rail.
  final Widget? fab;

  @override
  State<AppNavigationShell> createState() => _AppNavigationShellState();
}

class _AppNavigationShellState extends State<AppNavigationShell> {
  // Keeps the pages' state when they move between the bar and rail layouts.
  final _pagesKey = GlobalKey();

  void _select(int i) {
    if (i == widget.index) {
      widget.onReselect?.call(i);
      return;
    }
    Haptics.select();
    widget.onSelect(i);
  }

  @override
  Widget build(BuildContext context) {
    final useRail = Responsive.of(context).usesSideNavigation;

    final pages = KeyedSubtree(
      key: _pagesKey,
      child: FadeScaleIndexedStack(index: widget.index, children: widget.pages),
    );

    return Scaffold(
      body: Row(
        children: [
          if (useRail)
            AppSideRail(
              destinations: widget.destinations,
              index: widget.index,
              onSelect: _select,
              leading: widget.fab,
            ),
          Expanded(child: pages),
        ],
      ),
      bottomNavigationBar: useRail
          ? null
          : AppBottomBar(
              destinations: widget.destinations,
              index: widget.index,
              onSelect: _select,
            ),
      floatingActionButton: useRail ? null : widget.fab,
    );
  }
}
