import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'counterpart_balance_provider.dart';
import 'pay_selection.dart';
import 'pay_selection_controller.dart';

part 'pay_selection_provider.g.dart';

/// Las deudas pendientes que le debo a [creditorId] y cuáles van en el pago.
@riverpod
Future<PaySelection> paySelection(
  Ref ref,
  String teamId,
  String creditorId,
) async {
  final balance = await ref.watch(
    counterpartBalanceProvider(teamId, creditorId).future,
  );
  return PaySelection(
    payable: balance.iOwe.payable,
    excluded: ref.watch(paySelectionControllerProvider(teamId, creditorId)),
  );
}
