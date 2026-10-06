import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/order.dart';
import 'all_orders_provider.dart';

part 'orders_by_id_provider.g.dart';

/// Los pedidos por id, para nombrar deudas por su concepto.
@riverpod
Future<Map<String, Order>> ordersById(Ref ref) async => {
  for (final summary in await ref.watch(allOrdersProvider.future))
    summary.order.id: summary.order,
};
