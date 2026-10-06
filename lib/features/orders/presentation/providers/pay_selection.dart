import '../../../../core/money/money.dart';
import '../../domain/entities/debt.dart';

/// Lo que puedo pagarle a alguien y lo que va en este pago.
final class PaySelection {
  const new({required this.payable, required this.excluded});

  final List<Debt> payable;
  final Set<String> excluded;

  List<Debt> get selected => [
    for (final d in payable)
      if (!excluded.contains(d.id)) d,
  ];

  Money get total => Money.sum(selected.map((d) => d.amount));
}
