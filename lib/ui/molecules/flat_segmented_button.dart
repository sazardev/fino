import 'package:flutter/material.dart';

import '../../core/haptics/haptics.dart';

/// Flat single-choice segmented control: tonal fills instead of an outline.
/// [segments] pairs each value with its label.
class FlatSegmentedButton<T> extends StatelessWidget {
  const FlatSegmentedButton({
    super.key,
    required this.segments,
    required this.selected,
    required this.onChanged,
  });

  final List<(T value, String label)> segments;
  final T selected;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SegmentedButton<T>(
      showSelectedIcon: false,
      style: SegmentedButton.styleFrom(
        side: BorderSide.none,
        backgroundColor: scheme.surfaceContainerHigh,
        foregroundColor: scheme.onSurface,
        selectedBackgroundColor: scheme.primary,
        selectedForegroundColor: scheme.onPrimary,
      ),
      segments: [
        for (final (value, label) in segments)
          ButtonSegment(value: value, label: Text(label)),
      ],
      selected: {selected},
      onSelectionChanged: (s) {
        Haptics.select();
        onChanged(s.first);
      },
    );
  }
}
