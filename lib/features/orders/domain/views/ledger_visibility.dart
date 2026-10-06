import '../entities/debt.dart';
import '../entities/ledger_entry.dart';

/// Quién puede ver cada línea de la bitácora (SPEC §7.1, §11).
abstract final class LedgerVisibility {
  /// Cualquier miembro del equipo ve la línea de tiempo en solo lectura, salvo
  /// las confidenciales (referencia de pago, objeción): esas solo las ven
  /// el acreedor y el deudor de la deuda a la que pertenecen.
  static bool canView({
    required LedgerEntry entry,
    required String viewerId,
    required Debt? debt,
  }) {
    if (!entry.type.confidential) return true;
    if (debt == null) return false;
    return viewerId == debt.creditorId || viewerId == debt.debtorId;
  }
}
