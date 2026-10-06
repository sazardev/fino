import 'package:flutter/material.dart';

import '../../core/haptics/haptics.dart';

/// A Material [Switch] that also gives the toggle its haptic. Use it instead
/// of a bare `Switch` so every toggle feels the same.
class AppSwitch extends StatelessWidget {
  const new({required this.value, required this.onChanged, super.key});

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged == null
          ? null
          : (v) {
              Haptics.toggle(on: v);
              onChanged!(v);
            },
    );
  }
}
