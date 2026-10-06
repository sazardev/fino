import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/directory/directory_person.dart';
import '../../../../core/directory/team_people_provider.dart';
import 'order_provider.dart';

part 'debtor_candidates_provider.g.dart';

/// Quién más puede entrar al pedido: del equipo, que no sea quien pagó ni
/// tenga ya una deuda activa en él (P6).
@riverpod
Future<List<DirectoryPerson>> debtorCandidates(Ref ref, String orderId) async {
  final summary = await ref.watch(orderProvider(orderId).future);
  if (summary == null) return const [];
  final people = await ref.watch(
    teamPeopleProvider(summary.order.teamId).future,
  );
  final taken = {
    for (final d in summary.debts)
      if (d.status.isActive) d.debtorId,
  };
  return [
    for (final p in people)
      if (p.userId != summary.order.creditorId && !taken.contains(p.userId)) p,
  ];
}
