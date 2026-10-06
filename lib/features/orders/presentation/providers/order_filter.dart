import 'package:freezed_annotation/freezed_annotation.dart';

import 'order_list_status.dart';

part 'order_filter.freezed.dart';

/// Lo que la persona eligió para filtrar la lista de pedidos.
@freezed
abstract class OrderFilter with _$OrderFilter {
  const factory({
    @Default('') String query,
    @Default(OrderListStatus.all) OrderListStatus status,
    String? teamId,
    @Default(false) bool onlyMine,
  }) = _OrderFilter;
}
