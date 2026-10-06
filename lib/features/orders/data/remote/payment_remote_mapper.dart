import '../../../../core/sync/remote_marker.dart';
import '../../domain/entities/payment.dart';
import '../../domain/entities/payout_snapshot.dart';

/// [Payment] ↔ documento `teams/{team}/payments/{id}`.
abstract final class PaymentRemoteMapper {
  static String collection(String teamId) => 'teams/$teamId/payments';

  static Map<String, Object?> toCreateFields(Payment payment) => {
    'creditorId': payment.creditorId,
    'debtorId': payment.debtorId,
    'debtIds': payment.debtIds,
    'payoutShown': {
      'bankName': ?payment.payoutShown.bankName,
      'last4': payment.payoutShown.last4,
    },
    'reference': ?payment.reference,
    'reportedAt': RemoteMarker.serverTimestamp,
    'awaitingConfirmationReminderSent': false,
  };

  /// Lo único que cambia de un pago: que ya se avisó (#13).
  static Map<String, Object?> toReminderFields() => {
    'awaitingConfirmationReminderSent': true,
  };

  static Payment fromFields(
    String id,
    String teamId,
    Map<String, Object?> fields,
  ) {
    final shown = fields['payoutShown']! as Map<String, Object?>;
    return Payment(
      id: id,
      teamId: teamId,
      creditorId: fields['creditorId']! as String,
      debtorId: fields['debtorId']! as String,
      debtIds: (fields['debtIds']! as List<Object?>).cast<String>(),
      payoutShown: PayoutSnapshot(
        bankName: shown['bankName'] as String?,
        last4: shown['last4']! as String,
      ),
      reportedAt: fields['reportedAt']! as DateTime,
      awaitingConfirmationReminderSent:
          fields['awaitingConfirmationReminderSent']! as bool,
      reference: fields['reference'] as String?,
    );
  }
}
