import 'package:flutter/material.dart';

import '../design/app_spacing.dart';
import '../molecules/preset_tile.dart';

/// A list of one-tap presets, each with a mini [previewBuilder]: one per row
/// on a phone, two per row once there is room. Controlled through [selected]
/// and [onChanged]; [selected] is `null` when nothing matches.
class PresetPicker<T> extends StatelessWidget {
  const new({
    required this.items,
    required this.previewBuilder,
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final List<(T value, String label, String hint)> items;
  final Widget Function(T value) previewBuilder;
  final T? selected;
  final ValueChanged<T> onChanged;

  /// Narrowest width that still fits two tiles side by side.
  static const double twoColumnsFrom = 520;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        final columns = box.maxWidth >= twoColumnsFrom ? 2 : 1;
        final width = (box.maxWidth - AppSpacing.sm * (columns - 1)) / columns;

        return Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final (value, label, hint) in items)
              SizedBox(
                width: width,
                child: PresetTile(
                  preview: previewBuilder(value),
                  label: label,
                  hint: hint,
                  selected: value == selected,
                  onTap: () => onChanged(value),
                ),
              ),
          ],
        );
      },
    );
  }
}
