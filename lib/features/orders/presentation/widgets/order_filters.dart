import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/directory/my_teams_provider.dart';
import '../../../../ui/atoms/choice_pill.dart';
import '../../../../ui/design/app_spacing.dart';
import '../../../../ui/molecules/choice_pill_row.dart';
import '../../../../ui/molecules/search_field.dart';
import '../providers/order_filter_controller.dart';
import '../providers/order_list_status.dart';

/// Búsqueda y filtros de la lista de pedidos: estado, equipo y "solo míos".
class OrderFilters extends ConsumerWidget {
  const new({super.key});

  static const List<(OrderListStatus, String)> _statuses = [
    (OrderListStatus.all, 'Todos'),
    (OrderListStatus.open, 'Abiertos'),
    (OrderListStatus.settled, 'Saldados'),
    (OrderListStatus.cancelled, 'Cancelados'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(orderFilterControllerProvider);
    final controller = ref.read(orderFilterControllerProvider.notifier);
    final teams = ref.watch(myTeamsProvider).value ?? const [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SearchField(
          hint: 'Buscar por concepto o persona',
          onChanged: controller.search,
        ),
        const SizedBox(height: AppSpacing.sm),
        ChoicePillRow<OrderListStatus>(
          options: _statuses,
          selected: filter.status,
          onSelected: controller.showStatus,
        ),
        Row(
          children: [
            ChoicePill(
              label: 'Solo míos',
              icon: Icons.person_rounded,
              selected: filter.onlyMine,
              onTap: controller.toggleOnlyMine,
            ),
            const SizedBox(width: AppSpacing.sm),
            if (teams.length > 1)
              Expanded(
                child: ChoicePillRow<String?>(
                  options: [
                    (null, 'Todos los equipos'),
                    for (final team in teams) (team.id, team.name),
                  ],
                  selected: filter.teamId,
                  onSelected: controller.showTeam,
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
      ],
    );
  }
}
