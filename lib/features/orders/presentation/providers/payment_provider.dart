import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/orders_repository_provider.dart';
import '../../domain/entities/payment.dart';

part 'payment_provider.g.dart';

@riverpod
Future<Payment?> payment(Ref ref, String paymentId) =>
    ref.watch(ordersRepositoryProvider).findPayment(paymentId);
