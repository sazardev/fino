import '../../../../core/money/money.dart';
import '../failures/order_failure.dart';
import '../failures/order_failure_reason.dart';
import 'split_entry.dart';
import 'split_result.dart';

/// Reparte un total entre participantes (SPEC §5.2).
///
/// Los montos fijados se respetan; el resto se divide en partes iguales
/// (más una para el acreedor si [calculate] recibe `creditorIncluded`).
/// El redondeo a centavos lo absorbe siempre el acreedor (P5).
class SplitCalculator {
  const new();

  SplitResult calculate({
    required Money total,
    required String creditorId,
    required bool creditorIncluded,
    required List<SplitEntry> entries,
  }) {
    _validate(total, creditorId, entries);

    final fixedTotal = Money.sum(
      entries.map((e) => e.fixedAmount ?? Money.zero),
    );
    if (fixedTotal > total) {
      throw const OrderFailure(OrderFailureReason.fixedExceedsTotal);
    }

    final pool = total - fixedTotal;
    final free = entries.where((entry) => !entry.isFixed).length;
    final parts = free + (creditorIncluded ? 1 : 0);
    final share = parts == 0 ? Money.zero : Money(pool.cents ~/ parts);
    if (free > 0 && !share.isPositive) {
      throw const OrderFailure(OrderFailureReason.shareTooSmall);
    }

    return SplitResult(
      amountByDebtor: {
        for (final entry in entries) entry.userId: entry.fixedAmount ?? share,
      },
      creditorShare: pool - share * free,
    );
  }

  void _validate(Money total, String creditorId, List<SplitEntry> entries) {
    if (!total.isPositive) {
      throw const OrderFailure(OrderFailureReason.totalNotPositive);
    }
    if (entries.isEmpty) {
      throw const OrderFailure(OrderFailureReason.noDebtors);
    }
    final ids = entries.map((entry) => entry.userId).toSet();
    if (ids.length != entries.length) {
      throw const OrderFailure(OrderFailureReason.duplicateParticipant);
    }
    if (ids.contains(creditorId)) {
      throw const OrderFailure(OrderFailureReason.creditorCannotOwe);
    }
    final fixed = entries.map((entry) => entry.fixedAmount).nonNulls;
    if (fixed.any((amount) => !amount.isPositive)) {
      throw const OrderFailure(OrderFailureReason.amountNotPositive);
    }
  }
}
