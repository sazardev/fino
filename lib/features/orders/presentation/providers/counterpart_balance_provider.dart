import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/session/session_user_id_provider.dart';
import 'counterpart_balance.dart';
import 'counterpart_debts_provider.dart';
import 'person_balance.dart';

part 'counterpart_balance_provider.g.dart';

/// Lo que le debo a una persona y lo que me debe, en un equipo.
@riverpod
Future<CounterpartBalance> counterpartBalance(
  Ref ref,
  String teamId,
  String userId,
) async {
  final me = ref.watch(sessionUserIdProvider);
  final debts = await ref.watch(
    counterpartDebtsProvider(teamId, userId).future,
  );
  PersonBalance side({required bool iAmDebtor}) => PersonBalance(
    teamId: teamId,
    userId: userId,
    debts: [
      for (final d in debts)
        if ((iAmDebtor ? d.debtorId : d.creditorId) == me) d,
    ],
  );
  return CounterpartBalance(
    iOwe: side(iAmDebtor: true),
    owedToMe: side(iAmDebtor: false),
  );
}
