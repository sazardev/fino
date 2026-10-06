import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/session/session_user_id_provider.dart';
import '../../data/orders_repository_provider.dart';
import '../../domain/views/debt_book.dart';

part 'debt_book_provider.g.dart';

/// Debo / Me deben de quien está en sesión (SPEC §7.2).
@riverpod
Stream<DebtBook> debtBook(Ref ref) {
  final userId = ref.watch(sessionUserIdProvider);
  if (userId == null) return Stream.value(DebtBook('', const []));
  return ref
      .watch(ordersRepositoryProvider)
      .watchLiveDebtsOf(userId)
      .map((debts) => DebtBook(userId, debts));
}
