import '../../domain/entities/debt.dart';
import '../../domain/enums/debt_status.dart';
import 'debt_action.dart';

/// Qué acciones le tocan a alguien sobre una deuda según su rol y el estado
/// (SPEC §6.2, §12). Quien no es parte solo mira.
abstract final class AvailableDebtActions {
  static List<DebtAction> of(Debt debt, String? me) {
    if (me == debt.creditorId) {
      return switch (debt.status) {
        DebtStatus.paymentReported => const [
          DebtAction.confirm,
          DebtAction.reject,
        ],
        DebtStatus.pending => const [DebtAction.editAmount, DebtAction.cancel],
        DebtStatus.confirmed => const [DebtAction.undoConfirmation],
        DebtStatus.cancelled => const [],
      };
    }
    if (me == debt.debtorId) {
      return switch (debt.status) {
        DebtStatus.pending => const [DebtAction.pay, DebtAction.object],
        DebtStatus.paymentReported => const [DebtAction.retract],
        DebtStatus.confirmed || DebtStatus.cancelled => const [],
      };
    }
    return const [];
  }
}
