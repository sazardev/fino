import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/format/date_label.dart';
import '../../../../core/time/clock_provider.dart';
import '../../../../ui/molecules/choice_pill_row.dart';

/// Cuándo fue el gasto: hoy o alguno de los días anteriores (sin selectores
/// del sistema, DESIGN §1.5).
class SpentAtChoice extends ConsumerWidget {
  const new({required this.value, required this.onChanged, super.key});

  final DateTime value;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = ref.watch(clockProvider)().toLocal();
    final today = DateTime(now.year, now.month, now.day);
    final days = [
      for (var i = 0; i < 7; i++) today.subtract(Duration(days: i)),
    ];
    final chosen = value.toLocal();
    final selected = days.firstWhere(
      (d) =>
          d.year == chosen.year &&
          d.month == chosen.month &&
          d.day == chosen.day,
      orElse: () => days.first,
    );

    return ChoicePillRow<DateTime>(
      options: [for (final d in days) (d, DateLabel.of(d, now: now))],
      selected: selected,
      onSelected: (day) => onChanged(day.toUtc()),
    );
  }
}
