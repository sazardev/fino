import 'package:flutter/material.dart';

import '../../core/format/money_format.dart';
import '../../core/money/money.dart';
import '../theme/tabular_text.dart';

/// Un monto con cifras tabulares. Con [direction] lleva signo y color: nunca
/// solo color (DESIGN §2.4).
class AmountText extends StatelessWidget {
  const new(this.amount, {super.key, this.direction, this.style});

  final Money amount;

  /// `true` = me deben (+, acento); `false` = debo (−, error); `null` neutro.
  final bool? direction;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final base = style ?? Theme.of(context).textTheme.bodyLarge!;
    final (text, color) = switch (direction) {
      null => (MoneyFormat.format(amount), null),
      true => ('+${MoneyFormat.format(amount)}', scheme.primary),
      false => ('−${MoneyFormat.format(amount)}', scheme.error),
    };
    return Text(
      text,
      maxLines: 1,
      style: base.tabular.copyWith(fontWeight: FontWeight.w700, color: color),
    );
  }
}
