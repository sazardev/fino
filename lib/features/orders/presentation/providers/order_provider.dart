import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/orders_repository_provider.dart';
import '../../domain/views/order_summary.dart';

part 'order_provider.g.dart';

@riverpod
Stream<OrderSummary?> order(Ref ref, String orderId) =>
    ref.watch(ordersRepositoryProvider).watchOrder(orderId);
