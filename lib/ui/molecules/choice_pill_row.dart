import 'package:flutter/material.dart';

import '../atoms/choice_pill.dart';
import '../design/app_spacing.dart';

/// Una fila de [ChoicePill] que se desliza de lado si no cabe. [options]
/// empareja cada valor con su etiqueta.
class ChoicePillRow<T> extends StatelessWidget {
  const new({
    required this.options,
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final List<(T value, String label)> options;
  final T selected;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          for (final (value, label) in options)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: ChoicePill(
                label: label,
                selected: value == selected,
                onTap: () => onSelected(value),
              ),
            ),
        ],
      ),
    );
  }
}
