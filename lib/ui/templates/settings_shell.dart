import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../design/app_spacing.dart';
import '../molecules/floating_back_button.dart';
import '../molecules/screen_title.dart';
import '../responsive/app_layout.dart';
import '../responsive/responsive.dart';

/// Scaffold for a scrollable, sectioned screen. There is no top bar: an
/// optional [title] is the first element of the scroll, and a secondary screen
/// gets a floating back button. The content stays in a readable column that
/// grows with the screen (phone → tablet → web) and tightens on watches.
class SettingsShell extends StatelessWidget {
  const new({
    required this.children,
    super.key,
    this.title,
    this.loaded = true,
    this.wide = false,
  });

  final List<Widget> children;

  /// Only when it tells the user something the screen doesn't already.
  final String? title;

  /// While false a centred spinner is shown instead of [children].
  final bool loaded;

  /// Use the wider column meant for dense screens on large displays.
  final bool wide;

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final maxWidth = wide
        ? AppLayout.wideContentWidth(context)
        : r.contentWidth;
    final canGoBack = Navigator.of(context).canPop();
    final backSize = 44 * r.scale;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, box) {
            // Line the back button up with the content column's left edge.
            final backLeft = math.max(
              r.pagePadding / 2,
              (box.maxWidth - maxWidth) / 2,
            );

            return Stack(
              children: [
                if (!loaded)
                  const Center(child: CircularProgressIndicator())
                else
                  SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      r.pagePadding,
                      canGoBack ? backSize + AppSpacing.md : AppSpacing.sm,
                      r.pagePadding,
                      AppSpacing.xxl,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: maxWidth),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (title != null) ScreenTitle(title!),
                            ...children,
                          ],
                        ),
                      ),
                    ),
                  ),
                if (canGoBack)
                  Positioned(
                    left: backLeft,
                    top: AppSpacing.sm,
                    child: const FloatingBackButton(),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
