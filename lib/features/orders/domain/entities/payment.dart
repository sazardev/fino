import 'package:freezed_annotation/freezed_annotation.dart';

import 'payout_snapshot.dart';

part 'payment.freezed.dart';

/// Aviso "Ya pagué" que agrupa una o varias deudas con el mismo acreedor
/// (SPEC §6.3). Solo agrupa: cada deuda conserva su estado y su pedido.
@freezed
abstract class Payment with _$Payment {
  const factory({
    required String id,
    required String teamId,
    required String creditorId,
    required String debtorId,
    required List<String> debtIds,
    required PayoutSnapshot payoutShown,
    required DateTime reportedAt,
    @Default(false) bool awaitingConfirmationReminderSent,
    String? reference,
  }) = _Payment;
}
