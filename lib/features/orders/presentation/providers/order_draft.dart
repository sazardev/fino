import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/money/money.dart';

part 'order_draft.freezed.dart';

/// Un pedido a medio capturar (SPEC §5.1–5.2).
@freezed
abstract class OrderDraft with _$OrderDraft {
  const factory({
    required DateTime spentAt,
    String? teamId,
    @Default('') String concept,
    Money? total,
    @Default('') String note,

    /// "Yo también consumí": el acreedor cuenta como una parte más.
    @Default(true) bool creditorIncluded,

    /// Deudores elegidos, en el orden en que se agregaron.
    @Default([]) List<String> participants,

    /// Montos fijados a mano; los demás se reparten solos.
    @Default({}) Map<String, Money> fixed,
  }) = _OrderDraft;
}
