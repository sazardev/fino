import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/debt.dart';
import 'debt_book_provider.dart';

part 'counterpart_debts_provider.g.dart';

/// Mis deudas vivas con una persona en un equipo, en ambos sentidos.
@riverpod
Future<List<Debt>> counterpartDebts(
  Ref ref,
  String teamId,
  String userId,
) async {
  final book = await ref.watch(debtBookProvider.future);
  return [
    for (final group in [...book.iOwe, ...book.owedToMe])
      if (group.counterpartyId == userId)
        for (final debt in group.debts)
          if (debt.teamId == teamId) debt,
  ];
}
