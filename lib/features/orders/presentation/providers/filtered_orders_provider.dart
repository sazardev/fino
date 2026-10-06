import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/directory/people_provider.dart';
import '../../../../core/session/session_user_id_provider.dart';
import '../../domain/enums/order_status.dart';
import '../../domain/views/order_summary.dart';
import 'all_orders_provider.dart';
import 'order_filter.dart';
import 'order_filter_controller.dart';
import 'order_list_status.dart';

part 'filtered_orders_provider.g.dart';

/// La lista de pedidos ya filtrada: estado, equipo, "solo míos" y búsqueda
/// por concepto, nota o nombre de quien pagó (sin acentos ni mayúsculas).
@riverpod
Future<List<OrderSummary>> filteredOrders(Ref ref) async {
  final orders = await ref.watch(allOrdersProvider.future);
  final people = await ref.watch(peopleProvider.future);
  final filter = ref.watch(orderFilterControllerProvider);
  final me = ref.watch(sessionUserIdProvider);
  final query = _fold(filter.query.trim());

  bool matches(OrderSummary summary) {
    final order = summary.order;
    if (!_statusMatches(filter, summary.status)) return false;
    if (filter.teamId != null && order.teamId != filter.teamId) return false;
    if (filter.onlyMine &&
        order.creditorId != me &&
        !summary.debts.any((d) => d.debtorId == me)) {
      return false;
    }
    if (query.isEmpty) return true;
    final creditor = people['${order.teamId}/${order.creditorId}'];
    return [
      order.concept,
      order.note ?? '',
      creditor?.displayName ?? '',
    ].any((text) => _fold(text).contains(query));
  }

  return orders.where(matches).toList();
}

bool _statusMatches(OrderFilter filter, OrderStatus status) =>
    switch (filter.status) {
      OrderListStatus.all => true,
      OrderListStatus.open => status == OrderStatus.open,
      OrderListStatus.settled => status == OrderStatus.settled,
      OrderListStatus.cancelled => status == OrderStatus.cancelled,
    };

String _fold(String text) => text
    .toLowerCase()
    .replaceAll(RegExp('[áà]'), 'a')
    .replaceAll(RegExp('[éè]'), 'e')
    .replaceAll(RegExp('[íì]'), 'i')
    .replaceAll(RegExp('[óò]'), 'o')
    .replaceAll(RegExp('[úùü]'), 'u');
