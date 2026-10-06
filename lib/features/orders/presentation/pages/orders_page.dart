import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../ui/molecules/empty_state.dart';
import '../../../../ui/templates/list_shell.dart';
import '../providers/all_orders_provider.dart';
import '../providers/filtered_orders_provider.dart';
import '../widgets/order_filters.dart';
import '../widgets/order_tile.dart';

/// Todos los pedidos de mis equipos, con búsqueda y filtros (SPEC §7.1: el
/// equipo los ve todos en solo lectura). Sin título: la navegación ya dice
/// "Pedidos".
class OrdersPage extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(filteredOrdersProvider);
    final anyAtAll = ref.watch(
      allOrdersProvider.select((all) => all.value?.isNotEmpty ?? false),
    );
    final list = orders.value ?? const [];

    return ListShell(
      loaded: orders.hasValue,
      header: const [OrderFilters()],
      itemCount: list.length,
      itemBuilder: (context, i) => OrderTile(summary: list[i]),
      empty: anyAtAll
          ? const EmptyState(
              icon: Icons.search_off_rounded,
              title: 'Nada coincide',
              hint: 'Prueba con otra búsqueda o quita filtros.',
            )
          : const EmptyState(
              icon: Icons.receipt_long_rounded,
              title: 'Aún no hay pedidos',
              hint: 'Cuando alguien pague algo para el equipo, aparecerá aquí.',
            ),
    );
  }
}
