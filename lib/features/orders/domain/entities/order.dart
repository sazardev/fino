import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/money/money.dart';

part 'order.freezed.dart';

/// Un gasto que el acreedor ya pagó y reparte entre otros (SPEC §5).
///
/// Su estado no vive aquí: se deriva de sus deudas (`OrderSummary`).
@freezed
abstract class Order with _$Order {
  const factory({
    required String id,
    required String teamId,
    required String creditorId,
    required String concept,
    required Money total,
    required DateTime spentAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? note,
  }) = _Order;
}
