import 'package:flutter/material.dart';

import '../../responsive/responsive.dart';

/// Watch layout: round faces clip the corners, so the body stays inside the
/// inscribed circle's square and one small row of icons sits at the bottom.
class FloatingActionsWatchLayout extends StatelessWidget {
  const FloatingActionsWatchLayout({
    super.key,
    required this.body,
    required this.items,
    required this.responsive,
  });

  final Widget body;
  final List<Widget> items;
  final Responsive responsive;

  @override
  Widget build(BuildContext context) {
    final size = responsive.size;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        size.width * 0.1,
        size.height * 0.1,
        size.width * 0.1,
        size.height * 0.04,
      ),
      child: Column(
        children: [
          Expanded(child: body),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: items,
            ),
          ),
        ],
      ),
    );
  }
}
