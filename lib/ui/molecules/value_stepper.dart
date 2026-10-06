import 'package:flutter/material.dart';

import '../../core/haptics/haptics.dart';
import '../atoms/app_icon_button.dart';
import '../design/app_spacing.dart';

/// A labeled integer control: coarse slider plus −/+ buttons for exact steps.
class ValueStepper extends StatelessWidget {
  const new({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    super.key,
    this.format,
  });

  final String label;
  final int value;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  /// How the value reads (defaults to the plain number).
  final String Function(int value)? format;

  void _set(int next) {
    if (next == value) return;
    Haptics.tick();
    onChanged(next);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            AppIconButton(
              size: 36,
              tooltip: '-1',
              onPressed: value > min ? () => _set(value - 1) : null,
              icon: const Icon(Icons.remove_rounded, size: 20),
            ),
            SizedBox(
              width: 76,
              child: Text(
                format?.call(value) ?? '$value',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: scheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            AppIconButton(
              size: 36,
              tooltip: '+1',
              onPressed: value < max ? () => _set(value + 1) : null,
              icon: const Icon(Icons.add_rounded, size: 20),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Slider(
          value: value.toDouble(),
          min: min.toDouble(),
          max: max.toDouble(),
          divisions: max - min,
          onChanged: (v) => _set(v.round()),
        ),
      ],
    );
  }
}
