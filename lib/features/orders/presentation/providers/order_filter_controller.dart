import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'order_filter.dart';
import 'order_list_status.dart';

part 'order_filter_controller.g.dart';

/// Búsqueda y filtros de la lista de pedidos (sobreviven al cambiar de
/// destino).
@Riverpod(keepAlive: true)
class OrderFilterController extends _$OrderFilterController {
  @override
  OrderFilter build() => const OrderFilter();

  void search(String query) => state = state.copyWith(query: query);

  void showStatus(OrderListStatus status) =>
      state = state.copyWith(status: status);

  void showTeam(String? teamId) => state = state.copyWith(teamId: teamId);

  void toggleOnlyMine() => state = state.copyWith(onlyMine: !state.onlyMine);
}
