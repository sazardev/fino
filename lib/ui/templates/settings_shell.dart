import 'package:flutter/material.dart';

import '../design/app_spacing.dart';
import '../molecules/app_top_bar.dart';
import '../responsive/app_layout.dart';
import '../responsive/responsive.dart';

/// Scaffold for a scrollable, sectioned screen. Caps the content to a
/// readable column that grows with the screen (phone → tablet → desktop) and
/// tightens on watches.
class SettingsShell extends StatelessWidget {
  const SettingsShell({
    super.key,
    required this.title,
    required this.children,
    this.loaded = true,
    this.wide = false,
  });

  final String title;
  final List<Widget> children;

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

    return Scaffold(
      appBar: appTopBar(context, title: Text(title)),
      body: SafeArea(
        top: false,
        child: !loaded
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  r.pagePadding,
                  AppSpacing.sm,
                  r.pagePadding,
                  AppSpacing.xxl,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: children,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
