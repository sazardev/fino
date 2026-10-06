import '../../../../core/money/money.dart';
import '../../domain/entities/debt.dart';
import '../../domain/enums/debt_status.dart';

/// Lo vivo con una persona en un equipo, en un sentido (debo o me debe).
final class PersonBalance {
  const new({required this.teamId, required this.userId, required this.debts});

  final String teamId;
  final String userId;
  final List<Debt> debts;

  Money get total => Money.sum(debts.map((d) => d.amount));

  /// Con pago reportado, esperando al acreedor.
  List<Debt> get reported =>
      debts.where((d) => d.status == DebtStatus.paymentReported).toList();

  /// Las que aún se pueden pagar.
  List<Debt> get payable =>
      debts.where((d) => d.status == DebtStatus.pending).toList();
}
