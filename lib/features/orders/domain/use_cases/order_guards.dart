import '../failures/order_failure.dart';
import '../failures/order_failure_reason.dart';

/// Quién puede actuar sobre un pedido o una deuda (SPEC §12).
abstract final class OrderGuards {
  static void requireCreditor(String actorId, String creditorId) {
    if (actorId != creditorId) {
      throw const OrderFailure(OrderFailureReason.notCreditor);
    }
  }

  static void requireDebtor(String actorId, String debtorId) {
    if (actorId != debtorId) {
      throw const OrderFailure(OrderFailureReason.notDebtor);
    }
  }
}
