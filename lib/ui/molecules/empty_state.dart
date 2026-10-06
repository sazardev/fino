import 'package:flutter/material.dart';

import '../atoms/chubby_icon.dart';
import '../atoms/pop_in.dart';
import '../design/app_spacing.dart';

/// Big plump icon (that pops in) with a title and a hint.
class EmptyState extends StatelessWidget {
  const new({required this.icon, required this.title, super.key, this.hint});

  final IconData icon;
  final String title;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.huge),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PopIn(child: ChubbyIcon(icon, size: 64, color: scheme.primary)),
          const SizedBox(height: AppSpacing.lg),
          Text(
            title,
            textAlign: TextAlign.center,
            style: text.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          if (hint != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              hint!,
              textAlign: TextAlign.center,
              style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ],
        ],
      ),
    );
  }
}
