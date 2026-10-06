import 'package:flutter/material.dart';

import '../../design/app_spacing.dart';
import '../../organisms/action_bar.dart';
import '../../responsive/responsive.dart';
import 'action_bar_sizing.dart';

/// Phone / tablet / desktop layout: [body] big and centred, [header] on top,
/// and the action bar floating at the bottom (portrait) or the right edge
/// (rail).
class FloatingActionsLayout extends StatelessWidget {
  const FloatingActionsLayout({
    super.key,
    required this.body,
    required this.header,
    required this.items,
    required this.responsive,
  });

  final Widget body;
  final Widget? header;
  final List<Widget> items;
  final Responsive responsive;

  @override
  Widget build(BuildContext context) {
    final r = responsive;
    final vertical = useActionRail(r);

    return LayoutBuilder(
      builder: (context, box) {
        final size = actionButtonSize(
          r: r,
          box: box.biggest,
          vertical: vertical,
          count: items.length,
        );
        final reserve = actionBarReserve(
          r: r,
          buttonSize: size,
          vertical: vertical,
        );

        return Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: vertical
                    ? EdgeInsets.symmetric(
                        horizontal: reserve,
                        vertical: AppSpacing.lg,
                      )
                    : EdgeInsets.symmetric(vertical: reserve),
                child: body,
              ),
            ),
            if (header != null)
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.md),
                  child: header,
                ),
              ),
            Align(
              alignment: vertical
                  ? Alignment.centerRight
                  : Alignment.bottomCenter,
              child: Padding(
                padding: vertical
                    ? EdgeInsets.only(right: r.pagePadding * 0.6)
                    : const EdgeInsets.only(bottom: AppSpacing.lg),
                child: ActionBar(items: items, vertical: vertical, size: size),
              ),
            ),
          ],
        );
      },
    );
  }
}
