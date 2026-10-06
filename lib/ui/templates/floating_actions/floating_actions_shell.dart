import 'package:flutter/material.dart';

import '../../responsive/responsive.dart';
import 'floating_actions_layout.dart';
import 'floating_actions_watch_layout.dart';

/// Adaptive scaffold where the content is the star: big and dead centre,
/// with the controls as bare icons floating over the edge of the screen.
///
/// * Phones in portrait: a row at the bottom.
/// * Tablets, landscape, desktop: a column on the right.
/// * Watch: the body plus one small row of icons.
///
/// [primaryAction] (when given) is always the last button: bottom of the
/// column, right end of the row.
class FloatingActionsShell extends StatelessWidget {
  const FloatingActionsShell({
    super.key,
    required this.body,
    required this.actions,
    this.primaryAction,
    this.header,
    this.appBar,
  });

  final Widget body;

  /// Icon buttons, in order.
  final List<Widget> actions;

  /// The screen's main control, always placed last.
  final Widget? primaryAction;

  /// Small readout above the body (e.g. today's date).
  final Widget? header;
  final PreferredSizeWidget? appBar;

  List<Widget> get _items => [...actions, ?primaryAction];

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    return Scaffold(
      appBar: r.isWatch ? null : appBar,
      body: SafeArea(
        child: r.isWatch
            ? FloatingActionsWatchLayout(
                body: body,
                items: _items,
                responsive: r,
              )
            : FloatingActionsLayout(
                body: body,
                header: header,
                items: _items,
                responsive: r,
              ),
      ),
    );
  }
}
