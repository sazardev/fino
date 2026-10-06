import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:fino/core/money/money.dart';
import 'package:fino/core/notifications/intent/notification_kind.dart';
import 'package:fino/features/notices/domain/entities/notice_content.dart';
import 'package:fino/features/orders/domain/entities/debt.dart';
import 'package:fino/features/orders/domain/enums/debt_status.dart';
import 'package:fino/features/orders/domain/enums/ledger_event_type.dart';
import 'package:fino/features/orders/domain/enums/review_decision.dart';
import 'package:fino/features/orders/domain/split/split_entry.dart';
import 'package:fino/features/teams/domain/entities/clabe_payout.dart';
import 'package:fino/features/teams/domain/enums/team_role.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/debt_mapper_hack.dart';
import 'support/e2e_device.dart';
import 'support/rules_emulator.dart';

/// Dos dispositivos reales (Drift + sync) contra el emulador con las reglas
/// reales: lo que hace uno aparece en el otro.
void main() {
  if (skipWithoutRulesEmulator()) return;

  late E2eDevice omar;
  late E2eDevice ana;
  late String teamId;
  final opened = <E2eDevice>[];

  setUpAll(() => driftRuntimeOptions.dontWarnAboutMultipleDatabases = true);

  E2eDevice device(String name) {
    final d = E2eDevice.open(name);
    opened.add(d);
    return d;
  }

  tearDown(() async {
    for (final d in opened) {
      await d.close();
    }
    opened.clear();
  });

  Future<bool> idle(E2eDevice d) async => await d.db.outboxDao.head() == null;

  /// Omar crea el equipo, configura su cuenta y Ana entra con el código.
  Future<void> teamOfTwo() async {
    omar = device('omar')..start();
    ana = device('ana')..start();
    final team = await omar.createTeam(
      userId: omar.uid,
      name: 'Oficina',
      displayName: 'Omar',
    );
    teamId = team.id;
    await omar.setPayoutMethod(
      userId: omar.uid,
      teamId: teamId,
      method: ClabePayout.parse('012180000112345671', bankName: 'BBVA'),
    );
    await eventually(() => idle(omar), reason: 'omar outbox to drain');

    await ana.joinTeam(
      userId: ana.uid,
      displayName: 'Ana',
      code: team.inviteCode,
    );
    await eventually(() => idle(ana), reason: 'ana outbox to drain');
    await eventually(
      () async => (await omar.store.rosterOf(teamId)).isMember(ana.uid),
      reason: 'omar to see ana',
    );
  }

  Future<Debt> cafeForAna() async {
    await omar.createOrder(
      actorId: omar.uid,
      teamId: teamId,
      concept: 'Café',
      total: const Money(30000),
      spentAt: DateTime.now().toUtc(),
      creditorIncluded: true,
      entries: [SplitEntry(ana.uid)],
    );
    late Debt debt;
    await eventually(() async {
      final live = await ana.ordersRepo.watchLiveDebtsOf(ana.uid).first;
      if (live.isEmpty) return false;
      debt = live.single;
      return true;
    }, reason: 'ana to receive the debt');
    return debt;
  }

  group('teams', () {
    test('creating and joining: both devices converge on the team', () async {
      await teamOfTwo();

      await eventually(
        () async => await ana.store.findTeam(teamId) != null,
        reason: 'ana to download the team',
      );
      expect((await ana.store.findTeam(teamId))!.name, 'Oficina');
      await eventually(
        () async => (await ana.store.watchMembers(teamId).first).length == 2,
        reason: 'ana to download the members',
      );
      final roles = {
        for (final m in await ana.store.watchMembers(teamId).first)
          m.userId: m.role,
      };
      expect(roles, {omar.uid: TeamRole.admin, ana.uid: TeamRole.member});
      expect(
        (await omar.store.watchMembers(teamId).first).map((m) => m.displayName),
        containsAll(['Omar', 'Ana']),
      );
    });

    test('a wrong invite code is refused online', () async {
      await teamOfTwo();
      final zoe = device('zoe')..start();

      await expectLater(
        zoe.joinTeam(userId: zoe.uid, displayName: 'Zoe', code: 'NOPE0000'),
        throwsA(isA<Object>()),
      );
    });

    test('a regenerated code invalidates the old one', () async {
      await teamOfTwo();
      final old = (await omar.store.findTeam(teamId))!.inviteCode;

      final fresh = await omar.regenerateCode(
        actorId: omar.uid,
        teamId: teamId,
      );
      await eventually(() => idle(omar), reason: 'regeneration to sync');

      final zoe = device('zoe')..start();
      await expectLater(
        zoe.joinTeam(userId: zoe.uid, displayName: 'Zoe', code: old),
        throwsA(isA<Object>()),
      );
      await zoe.joinTeam(userId: zoe.uid, displayName: 'Zoe', code: fresh);
      await eventually(
        () async => (await omar.store.rosterOf(teamId)).isMember(zoe.uid),
        reason: 'zoe to join with the new code',
      );
    });

    test('leaving purges the leaver and the admin sees it', () async {
      await teamOfTwo();

      await ana.leaveTeam(userId: ana.uid, teamId: teamId);
      await eventually(() => idle(ana), reason: 'leave to sync');

      expect(await ana.store.findTeam(teamId), isNull);
      await eventually(
        () async => !(await omar.store.rosterOf(teamId)).isMember(ana.uid),
        reason: 'omar to see ana gone',
      );
    });

    test('deleting the team removes it from the other devices', () async {
      await teamOfTwo();

      await omar.deleteTeam(actorId: omar.uid, teamId: teamId);

      await eventually(
        () async => await ana.store.findTeam(teamId) == null,
        reason: 'ana to lose the team',
      );
    });
  });

  group('the debt lifecycle', () {
    setUp(teamOfTwo);

    test(
      'an order reaches the debtor with its notification and payout access',
      () async {
        final debt = await cafeForAna();

        expect(debt.amount, const Money(15000));
        await eventually(
          () async => (await ana.inbox.watch(ana.uid).first).any(
            (n) => n.intent.kind == NotificationKind.orderDebtCreated,
          ),
          reason: 'ana to get the notification',
        );
        await eventually(
          () async =>
              await ana.store.watchPayoutMethod(teamId, omar.uid).first != null,
          reason: 'ana to read the payout method (M4)',
        );
      },
    );

    test(
      'report → confirm: both sides converge and access is withdrawn',
      () async {
        final debt = await cafeForAna();
        await eventually(
          () async =>
              await ana.store.watchPayoutMethod(teamId, omar.uid).first != null,
          reason: 'payout visible',
        );

        await ana.reportPayment(
          actorId: ana.uid,
          debtIds: [debt.id],
          shownAmounts: {debt.id: debt.amount},
          reference: 'SPEI-1',
        );
        await eventually(
          () async =>
              (await omar.ordersRepo.findDebts([debt.id])).single.status ==
              DebtStatus.paymentReported,
          reason: 'omar to see the report',
        );
        await eventually(
          () async => (await omar.inbox.watch(omar.uid).first).any(
            (n) => n.intent.kind == NotificationKind.paymentReported,
          ),
          reason: 'omar to get the notification',
        );

        await omar.reviewDebts(
          actorId: omar.uid,
          decisions: [
            (debtId: debt.id, decision: ReviewDecision.confirm, note: null),
          ],
        );
        await eventually(
          () async =>
              (await ana.ordersRepo.findDebts([debt.id])).single.status ==
              DebtStatus.confirmed,
          reason: 'ana to see the confirmation',
        );
        await eventually(
          () async =>
              await ana.store.watchPayoutMethod(teamId, omar.uid).first == null,
          reason: 'ana to lose payout access',
        );
        expect(await ana.ordersRepo.watchLiveDebtsOf(ana.uid).first, isEmpty);
      },
    );

    test(
      'the reference is confidential: a third member never sees it',
      () async {
        final debt = await cafeForAna();
        await eventually(
          () async =>
              await ana.store.watchPayoutMethod(teamId, omar.uid).first != null,
          reason: 'payout visible',
        );
        await ana.reportPayment(
          actorId: ana.uid,
          debtIds: [debt.id],
          shownAmounts: {debt.id: debt.amount},
          reference: 'SPEI-SECRETA',
        );
        final beto = device('beto')..start();
        await omar.regenerateCode(actorId: omar.uid, teamId: teamId);
        await eventually(() => idle(omar), reason: 'code to sync');
        await beto.joinTeam(
          userId: beto.uid,
          displayName: 'Beto',
          code: (await omar.store.findTeam(teamId))!.inviteCode,
        );

        await eventually(
          () async =>
              (await beto.ordersRepo.watchTeamOrders(teamId).first).isNotEmpty,
          reason: 'beto to see the team orders (7.1)',
        );
        final order =
            (await omar.ordersRepo.watchTeamOrders(teamId).first).single;
        await eventually(
          () async =>
              (await omar.ordersRepo
                      .watchTimeline(order.order.id, omar.uid)
                      .first)
                  .any((e) => e.type == LedgerEventType.paymentReported),
          reason: 'omar to see the report line',
        );

        final forBeto = await beto.ordersRepo
            .watchTimeline(order.order.id, beto.uid)
            .first;
        expect(forBeto.map((e) => e.note), isNot(contains('SPEI-SECRETA')));
        expect(
          forBeto.map((e) => e.type),
          isNot(contains(LedgerEventType.paymentReported)),
        );
      },
    );

    test(
      'offline actions queue and flow when the connection returns',
      () async {
        final debt = await cafeForAna();
        await eventually(
          () async =>
              await ana.store.watchPayoutMethod(teamId, omar.uid).first != null,
          reason: 'payout visible',
        );
        ana.net.online = false;

        await ana.reportPayment(
          actorId: ana.uid,
          debtIds: [debt.id],
          shownAmounts: {debt.id: debt.amount},
        );
        await Future<void>.delayed(const Duration(milliseconds: 400));

        expect(
          (await ana.ordersRepo.findDebts([debt.id])).single.status,
          DebtStatus.paymentReported,
        );
        expect(await ana.db.outboxDao.head(), isNotNull);
        expect(
          (await omar.ordersRepo.findDebts([debt.id])).single.status,
          DebtStatus.pending,
        );

        ana.net.online = true;
        await ana.db.outboxDao.markBatchFailed(
          await ana.db.select(ana.db.outboxEntries).get(),
          now: DateTime.utc(2000),
        );
        await ana.coordinator.flushNow();

        await eventually(
          () async =>
              (await omar.ordersRepo.findDebts([debt.id])).single.status ==
              DebtStatus.paymentReported,
          reason: 'omar to receive the offline report',
        );
      },
    );

    test('a batch the rules reject is dropped and local state heals', () async {
      final debt = await cafeForAna();
      // Un cliente tramposo: Ana se "confirma" su propia deuda.
      await ana.db.debtsDao.upsertDebts([DebtMapperHack.confirmed(debt)]);
      await ana.db.outboxDao.enqueueBatch(
        DebtMapperHack.illegalConfirmation(teamId, debt),
        batchId: 'cheat',
        now: DateTime.now().toUtc(),
      );
      await ana.coordinator.flushNow();

      await eventually(
        () async =>
            (await ana.ordersRepo.findDebts([debt.id])).single.status ==
            DebtStatus.pending,
        reason: 'the rejected state to be undone',
      );
      expect(await ana.db.outboxDao.head(), isNull);
    });

    test('a notice reaches its recipient with what they owe', () async {
      await cafeForAna();

      await omar.sendNotice(
        senderId: omar.uid,
        teamId: teamId,
        recipientIds: [ana.uid],
        content: NoticeContent.custom('ya paguen'),
      );

      await eventually(
        () async => (await ana.inbox.watch(ana.uid).first).any(
          (n) =>
              n.intent.kind == NotificationKind.notice &&
              n.intent.amount == const Money(15000),
        ),
        reason: 'ana to get the notice',
      );
    });

    test('cancelling a debt reaches the debtor', () async {
      final debt = await cafeForAna();

      await omar.cancelDebt(actorId: omar.uid, debtId: debt.id);

      await eventually(
        () async =>
            (await ana.ordersRepo.findDebts([debt.id])).single.status ==
            DebtStatus.cancelled,
        reason: 'ana to see the cancellation',
      );
    });
  });
}
