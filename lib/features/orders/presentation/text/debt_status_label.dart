import '../../domain/enums/debt_status.dart';

/// El estado de una deuda dicho desde el lado de quien la mira.
abstract final class DebtStatusLabel {
  static String of(DebtStatus status, {required bool iAmCreditor}) =>
      switch (status) {
        DebtStatus.pending => 'Pendiente',
        DebtStatus.paymentReported =>
          iAmCreditor ? 'Por confirmar' : 'Esperando confirmación',
        DebtStatus.confirmed => 'Pagada',
        DebtStatus.cancelled => 'Cancelada',
      };
}
