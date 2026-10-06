import '../../../../core/money/money.dart';
import '../entities/debt.dart';
import '../enums/debt_status.dart';

/// Deudas vivas con una misma persona, para las listas Debo / Me deben.
final class DebtGroup {
  const new(this.counterpartyId, this.debts);

  final String counterpartyId;
  final List<Debt> debts;

  Money get total => Money.sum(debts.map((debt) => debt.amount));

  /// Las que el deudor aún puede pagar (selección para "Pagar todo").
  List<Debt> get payable =>
      debts.where((debt) => debt.status == DebtStatus.pending).toList();

  /// Las que esperan la confirmación del acreedor.
  List<Debt> get awaitingConfirmation =>
      debts.where((debt) => debt.status == DebtStatus.paymentReported).toList();
}
