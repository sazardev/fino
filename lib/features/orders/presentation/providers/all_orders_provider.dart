import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/orders_repository_provider.dart';
import '../../domain/views/order_summary.dart';

part 'all_orders_provider.g.dart';

/// Todos los pedidos de mis equipos (SPEC §7.1: el equipo los ve todos).
@riverpod
Stream<List<OrderSummary>> allOrders(Ref ref) =>
    ref.watch(ordersRepositoryProvider).watchAllOrders();
