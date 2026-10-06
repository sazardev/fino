import 'package:flutter/material.dart';

import '../design/app_spacing.dart';

/// A title that is *content*: the first element of the scroll, never a bar.
/// Use it only when it tells the user something the screen doesn't already
/// (the person's name on their detail, "New entry" on a form).
class ScreenTitle extends StatelessWidget {
  const new(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall
            ?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}
