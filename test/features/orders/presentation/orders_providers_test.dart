import 'package:fino/core/database/app_database_provider.dart';
import 'package:fino/core/money/money.dart';
import 'package:fino/core/session/session_user_id_provider.dart';
import 'package:fino/core/time/clock_provider.dart';
import 'package:fino/features/orders/domain/failures/order_failure_reason.dart';
import 'package:fino/features/orders/presentation/providers/balance_view_provider.dart';
import 'package:fino/features/orders/presentation/providers/counterpart_balance_provider.dart';
import 'package:fino/features/orders/presentation/providers/debtor_candidates_provider.dart';
import 'package:fino/features/orders/presentation/providers/draft_split_provider.dart';
import 'package:fino/features/orders/presentation/providers/draft_team_id_provider.dart';
import 'package:fino/features/orders/presentation/providers/filtered_orders_provider.dart';
import 'package:fino/features/orders/presentation/providers/order_draft_controller.dart';
import 'package:fino/features/orders/presentation/providers/order_filter_controller.dart';
import 'package:fino/features/orders/presentation/providers/order_list_status.dart';
import 'package:fino/features/orders/presentation/providers/pay_selection_controller.dart';
import 'package:fino/features/orders/presentation/providers/pay_selection_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../support/seed_fino.dart';
import '../../../support/test_overrides.dart';

void main() {
  late ProviderContainer container;

  setUp(() async {
    final db = testDatabase();
    await seedFino(db);
    container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        sessionUserIdProvider.overrideWithValue('u1'),
        clockProvider.overrideWithValue(() => seededAt),
      ],
    );
    addTearDown(() async {
      container.dispose();
      await db.close();
    });
  });

  T keep<T>(ProviderListenable<T> provider) {
    container.listen(provider, (_, _) {});
    return container.read(provider);
  }

  test('Inicio groups by person and team, biggest first (SPEC 7.2)', () async {
    keep(balanceViewProvider);
    final view = await container.read(balanceViewProvider.future);

    expect(view.totalOwedToMe, const Money(20000));
    expect(view.totalIOwe, const Money(10000));
    expect(view.toConfirm.single.userId, 'u3');
    expect(view.iOwe.single.userId, 'u2');
    expect(view.isEmpty, isFalse);
  });

  test('counterpart and pay selection with a person', () async {
    keep(paySelectionProvider('t1', 'u2'));
    final balance = await container.read(
      counterpartBalanceProvider('t1', 'u2').future,
    );
    expect(balance.iOwe.total, const Money(10000));
    expect(balance.owedToMe.payable.single.id, 'd1');
    expect(balance.isEmpty, isFalse);

    var selection = await container.read(
      paySelectionProvider('t1', 'u2').future,
    );
    expect(selection.total, const Money(10000));

    container
        .read(paySelectionControllerProvider('t1', 'u2').notifier)
        .toggle('d3');
    selection = await container.read(paySelectionProvider('t1', 'u2').future);
    expect(selection.selected, isEmpty);
    container
        .read(paySelectionControllerProvider('t1', 'u2').notifier)
        .toggle('d3');
    selection = await container.read(paySelectionProvider('t1', 'u2').future);
    expect(selection.selected.single.id, 'd3');
  });

  test('order filters: status, team, mine and accent-free search', () async {
    keep(filteredOrdersProvider);
    Future<List<String>> concepts() async => [
      for (final s in await container.read(filteredOrdersProvider.future))
        s.order.concept,
    ];
    final filter = container.read(orderFilterControllerProvider.notifier);

    expect(await concepts(), unorderedEquals(['Café', 'Comida']));
    filter.search('CAFE');
    expect(await concepts(), ['Café']);
    filter.search('beto');
    expect(await concepts(), ['Comida']);
    filter
      ..search('')
      ..showStatus(OrderListStatus.settled);
    expect(await concepts(), isEmpty);
    filter
      ..showStatus(OrderListStatus.open)
      ..showTeam('t1')
      ..toggleOnlyMine();
    expect(await concepts(), unorderedEquals(['Café', 'Comida']));
    filter.showTeam('other');
    expect(await concepts(), isEmpty);
    filter
      ..showTeam(null)
      ..showStatus(OrderListStatus.cancelled);
    expect(await concepts(), isEmpty);
  });

  test('candidates to join an order exclude me and its debtors', () async {
    keep(debtorCandidatesProvider('o2'));
    final candidates = await container.read(
      debtorCandidatesProvider('o2').future,
    );
    expect(candidates.map((p) => p.userId), ['u3']);
    keep(debtorCandidatesProvider('ghost'));
    expect(
      await container.read(debtorCandidatesProvider('ghost').future),
      isEmpty,
    );
  });

  test('the draft splits live with the same rules it saves with', () async {
    keep(draftSplitProvider);
    keep(draftTeamIdProvider);
    final draft = container.read(orderDraftControllerProvider.notifier);

    expect(
      container.read(draftSplitProvider).problem,
      OrderFailureReason.totalNotPositive,
    );
    draft.setTotal(const Money(30000));
    expect(
      container.read(draftSplitProvider).problem,
      OrderFailureReason.noDebtors,
    );

    draft
      ..selectTeam('t1')
      ..toggleParticipant('u2')
      ..toggleParticipant('u3')
      ..setConcept('Pizza')
      ..setNote('viernes')
      ..setSpentAt(seededAt);
    var split = container.read(draftSplitProvider);
    expect(split.amounts, {'u2': const Money(10000), 'u3': const Money(10000)});
    expect(split.creditorShare, const Money(10000));
    expect(split.isValid, isTrue);

    draft.setFixed('u2', const Money(20000));
    split = container.read(draftSplitProvider);
    expect(split.amounts['u3'], const Money(5000));

    draft
      ..toggleCreditorIncluded()
      ..setFixed('u2', null)
      ..toggleParticipant('u3');
    split = container.read(draftSplitProvider);
    expect(split.amounts, {'u2': const Money(30000)});

    draft.setFixed('u2', const Money(99999));
    expect(
      container.read(draftSplitProvider).problem,
      OrderFailureReason.fixedExceedsTotal,
    );

    draft.selectTeam('t1');
    expect(container.read(orderDraftControllerProvider).participants, ['u2']);
    draft.selectTeam('t2');
    expect(container.read(orderDraftControllerProvider).participants, isEmpty);
    expect(container.read(draftTeamIdProvider), 't2');
  });
}
