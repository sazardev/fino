import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/session/session_user_id_provider.dart';
import '../../data/orders_repository_provider.dart';
import '../../domain/entities/debt.dart';

part 'closed_debts_provider.g.dart';

/// Historial: deudas confirmadas o canceladas donde soy parte.
@riverpod
Stream<List<Debt>> closedDebts(Ref ref) {
  final userId = ref.watch(sessionUserIdProvider);
  if (userId == null) return Stream.value(const []);
  return ref.watch(ordersRepositoryProvider).watchClosedDebtsOf(userId);
}
