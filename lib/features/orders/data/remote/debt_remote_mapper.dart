import '../../../../core/money/money.dart';
import '../../../../core/sync/remote_marker.dart';
import '../../domain/entities/debt.dart';
import '../../domain/enums/debt_status.dart';

/// [Debt] ↔ documento `teams/{team}/debts/{id}`.
abstract final class DebtRemoteMapper {
  static String collection(String teamId) => 'teams/$teamId/debts';

  static Map<String, Object?> toCreateFields(Debt debt) => {
    'orderId': debt.orderId,
    'creditorId': debt.creditorId,
    'debtorId': debt.debtorId,
    'amount': debt.amount.cents,
    'status': debt.status.name,
    'createdAt': RemoteMarker.serverTimestamp,
    'updatedAt': RemoteMarker.serverTimestamp,
  };

  /// Lo que cambia en una transición (SPEC 6.1). Sin pago, el campo se borra.
  static Map<String, Object?> toUpdateFields(Debt debt) => {
    'amount': debt.amount.cents,
    'status': debt.status.name,
    'paymentId': debt.paymentId ?? RemoteMarker.fieldDelete,
    'updatedAt': RemoteMarker.serverTimestamp,
  };

  static Debt fromFields(
    String id,
    String teamId,
    Map<String, Object?> fields,
  ) => Debt(
    id: id,
    orderId: fields['orderId']! as String,
    teamId: teamId,
    creditorId: fields['creditorId']! as String,
    debtorId: fields['debtorId']! as String,
    amount: Money(fields['amount']! as int),
    status: DebtStatus.values.byName(fields['status']! as String),
    paymentId: fields['paymentId'] as String?,
    createdAt: fields['createdAt']! as DateTime,
    updatedAt: fields['updatedAt']! as DateTime,
  );
}
