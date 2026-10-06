import '../../../../core/notifications/intent/notification_intent.dart';
import 'debt.dart';
import 'ledger_entry.dart';
import 'order.dart';
import 'payment.dart';

/// Lo que una acción de negocio cambió: lo que la capa de datos debe
/// guardar (en una sola operación) y lo que debe notificar.
///
/// Solo contiene lo que cambió: una acción repetida (no-op) devuelve
/// [OrderChangeSet.empty].
final class OrderChangeSet {
  const new({
    this.order,
    this.debts = const [],
    this.payments = const [],
    this.ledger = const [],
    this.notifications = const [],
  });

  static const empty = OrderChangeSet();

  final Order? order;
  final List<Debt> debts;
  final List<Payment> payments;
  final List<LedgerEntry> ledger;
  final List<NotificationIntent> notifications;

  bool get isEmpty =>
      order == null &&
      debts.isEmpty &&
      payments.isEmpty &&
      ledger.isEmpty &&
      notifications.isEmpty;
}
