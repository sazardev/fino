import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/format/date_label.dart';
import '../../../../core/time/clock_provider.dart';
import '../../domain/entities/debt.dart';
import '../../domain/enums/debt_status.dart';
import '../navigation/orders_navigator_provider.dart';
import '../providers/orders_by_id_provider.dart';
import '../text/debt_status_label.dart';
import 'debt_line.dart';

/// Una deuda con alguien, nombrada por su pedido; lleva al pedido.
class CounterpartDebtLine extends ConsumerWidget {
  const new({required this.debt, required this.iAmCreditor, super.key});

  final Debt debt;
  final bool iAmCreditor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(
      ordersByIdProvider.select((o) => o.value?[debt.orderId]),
    );
    final now = ref.watch(clockProvider)();

    return DebtLine(
      concept: order?.concept ?? 'Pedido',
      caption: order == null ? null : DateLabel.of(order.spentAt, now: now),
      status: DebtStatusLabel.of(debt.status, iAmCreditor: iAmCreditor),
      strongStatus: iAmCreditor && debt.status == DebtStatus.paymentReported,
      amount: debt.amount,
      direction: iAmCreditor,
      onTap: () => ref.read(ordersNavigatorProvider).openOrder(debt.orderId),
    );
  }
}
