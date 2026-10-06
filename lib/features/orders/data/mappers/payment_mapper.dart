import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/payment.dart';
import '../../domain/entities/payout_snapshot.dart';

/// Fila local ↔ [Payment].
abstract final class PaymentMapper {
  static Payment toDomain(PaymentRow row) => Payment(
    id: row.id,
    teamId: row.teamId,
    creditorId: row.creditorId,
    debtorId: row.debtorId,
    debtIds: row.debtIds,
    payoutShown: PayoutSnapshot(
      bankName: row.payoutBankName,
      last4: row.payoutLast4,
    ),
    reportedAt: row.reportedAt.toUtc(),
    awaitingConfirmationReminderSent: row.awaitingConfirmationReminderSent,
    reference: row.reference,
  );

  static PaymentsCompanion toCompanion(Payment payment) =>
      PaymentsCompanion.insert(
        id: payment.id,
        teamId: payment.teamId,
        creditorId: payment.creditorId,
        debtorId: payment.debtorId,
        debtIds: payment.debtIds,
        payoutBankName: Value(payment.payoutShown.bankName),
        payoutLast4: payment.payoutShown.last4,
        reference: Value(payment.reference),
        reportedAt: payment.reportedAt,
        awaitingConfirmationReminderSent: Value(
          payment.awaitingConfirmationReminderSent,
        ),
      );
}
