import 'package:flutter/material.dart';

import '../responsive/ui_size.dart';
import 'flat_segmented_button.dart';

/// Picks the interface size (text, icons and widths scale with it).
class UiSizeSelector extends StatelessWidget {
  const new({required this.size, required this.onChanged, super.key});

  final UiSize size;
  final ValueChanged<UiSize> onChanged;

  @override
  Widget build(BuildContext context) {
    return FlatSegmentedButton<UiSize>(
      segments: const [
        (UiSize.small, 'S'),
        (UiSize.normal, 'M'),
        (UiSize.large, 'L'),
        (UiSize.extraLarge, 'XL'),
      ],
      selected: size,
      onChanged: onChanged,
    );
  }
}
