import 'package:flutter/material.dart';

import '../../../../ui/design/app_spacing.dart';
import '../../../../ui/molecules/balance_card.dart';
import '../providers/balance_view.dart';

/// Los dos totales de Inicio: lo que me deben y lo que debo. Lado a lado si
/// caben; uno sobre otro en pantallas angostas.
class BalanceHeader extends StatelessWidget {
  const new({required this.view, super.key});

  final BalanceView view;

  @override
  Widget build(BuildContext context) {
    final owed = BalanceCard(
      label: 'Te deben',
      amount: view.totalOwedToMe,
      direction: true,
      caption: _people(view.owedToMe.length),
    );
    final owe = BalanceCard(
      label: 'Debes',
      amount: view.totalIOwe,
      direction: false,
      caption: _people(view.iOwe.length),
    );

    return LayoutBuilder(
      builder: (context, box) => box.maxWidth < 340
          ? Column(
              children: [
                owed,
                const SizedBox(height: AppSpacing.sm),
                owe,
              ],
            )
          : Row(
              children: [
                Expanded(child: owed),
                const SizedBox(width: AppSpacing.sm),
                Expanded(child: owe),
              ],
            ),
    );
  }

  static String _people(int count) => switch (count) {
    0 => 'Nadie',
    1 => '1 persona',
    _ => '$count personas',
  };
}
