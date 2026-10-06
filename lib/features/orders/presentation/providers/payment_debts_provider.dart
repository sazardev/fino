import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/orders_repository_provider.dart';
import '../../domain/entities/debt.dart';

part 'payment_debts_provider.g.dart';

/// Las deudas que siguen ligadas a un pago.
@riverpod
Stream<List<Debt>> paymentDebts(Ref ref, String paymentId) =>
    ref.watch(ordersRepositoryProvider).watchDebtsOfPayment(paymentId);
