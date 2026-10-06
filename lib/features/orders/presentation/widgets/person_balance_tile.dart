import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/directory/directory_person.dart';
import '../../../../core/directory/people_provider.dart';
import '../../../../ui/molecules/amount_text.dart';
import '../../../../ui/molecules/person_tile.dart';
import '../navigation/orders_navigator_provider.dart';
import '../providers/person_balance.dart';

/// Una persona en Inicio: cuánto le debo o me debe en un equipo.
class PersonBalanceTile extends ConsumerWidget {
  const new({required this.balance, required this.owedToMe, super.key});

  final PersonBalance balance;

  /// `true`: me debe; `false`: le debo.
  final bool owedToMe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = DirectoryPerson.keyOf(balance.teamId, balance.userId);
    final person = ref.watch(peopleProvider.select((p) => p.value?[key]));
    final name = person?.displayName ?? 'Alguien';

    return PersonTile(
      name: name,
      seed: balance.userId,
      photoUrl: person?.photoUrl,
      subtitle: _subtitle(),
      trailing: AmountText(balance.total, direction: owedToMe),
      onTap: () => ref
          .read(ordersNavigatorProvider)
          .openCounterpart(balance.teamId, balance.userId),
    );
  }

  String _subtitle() {
    final count = balance.debts.length;
    final debts = count == 1 ? '1 deuda' : '$count deudas';
    final reported = balance.reported.length;
    if (reported == 0) return debts;
    return owedToMe
        ? '$debts · $reported por confirmar'
        : '$debts · $reported esperando confirmación';
  }
}
