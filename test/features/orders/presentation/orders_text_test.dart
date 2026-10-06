import 'package:fino/core/money/money.dart';
import 'package:fino/features/orders/domain/entities/ledger_entry.dart';
import 'package:fino/features/orders/domain/enums/debt_status.dart';
import 'package:fino/features/orders/domain/enums/ledger_event_type.dart';
import 'package:fino/features/orders/domain/enums/order_status.dart';
import 'package:fino/features/orders/domain/failures/order_failure.dart';
import 'package:fino/features/orders/domain/failures/order_failure_reason.dart';
import 'package:fino/features/orders/presentation/providers/available_debt_actions.dart';
import 'package:fino/features/orders/presentation/providers/debt_action.dart';
import 'package:fino/features/orders/presentation/text/debt_status_label.dart';
import 'package:fino/features/orders/presentation/text/describe_order_error.dart';
import 'package:fino/features/orders/presentation/text/ledger_entry_text.dart';
import 'package:fino/features/orders/presentation/text/order_failure_message.dart';
import 'package:fino/features/orders/presentation/text/order_status_label.dart';
import 'package:flutter_test/flutter_test.dart';

import '../domain/support/order_fixtures.dart';

void main() {
  group('AvailableDebtActions (SPEC 6.2)', () {
    List<DebtAction> of(DebtStatus status, String me) =>
        AvailableDebtActions.of(buildDebt(status: status), me);

    test('the creditor', () {
      expect(of(DebtStatus.paymentReported, 'omar'), [
        DebtAction.confirm,
        DebtAction.reject,
      ]);
      expect(of(DebtStatus.pending, 'omar'), [
        DebtAction.editAmount,
        DebtAction.cancel,
      ]);
      expect(of(DebtStatus.confirmed, 'omar'), [DebtAction.undoConfirmation]);
      expect(of(DebtStatus.cancelled, 'omar'), isEmpty);
    });

    test('the debtor', () {
      expect(of(DebtStatus.pending, 'ana'), [
        DebtAction.pay,
        DebtAction.object,
      ]);
      expect(of(DebtStatus.paymentReported, 'ana'), [DebtAction.retract]);
      expect(of(DebtStatus.confirmed, 'ana'), isEmpty);
    });

    test('anyone else only watches (7.1)', () {
      for (final status in DebtStatus.values) {
        expect(of(status, 'beto'), isEmpty);
      }
      expect(AvailableDebtActions.of(buildDebt(), null), isEmpty);
    });
  });

  test('every failure has a message', () {
    for (final reason in OrderFailureReason.values) {
      expect(OrderFailureMessage.of(reason), isNotEmpty, reason: reason.name);
    }
    expect(
      describeOrderError(const OrderFailure(OrderFailureReason.notFound)),
      'Ya no existe',
    );
    expect(describeOrderError(StateError('x')), isNull);
  });

  test('statuses read from each side', () {
    expect(
      DebtStatusLabel.of(DebtStatus.paymentReported, iAmCreditor: true),
      'Por confirmar',
    );
    expect(
      DebtStatusLabel.of(DebtStatus.paymentReported, iAmCreditor: false),
      'Esperando confirmación',
    );
    for (final status in DebtStatus.values) {
      expect(DebtStatusLabel.of(status, iAmCreditor: false), isNotEmpty);
    }
    for (final status in OrderStatus.values) {
      expect(OrderStatusLabel.of(status), isNotEmpty);
    }
  });

  test('every ledger line reads as a sentence', () {
    for (final type in LedgerEventType.values) {
      final entry = LedgerEntry(
        id: 'l',
        orderId: 'o',
        type: type,
        actorId: 'a',
        at: t0,
        amountBefore: const Money(6000),
        amountAfter: const Money(4000),
        note: 'nota',
      );
      final text = LedgerEntryText.of(entry, actor: 'Ana', debtor: 'Beto');
      expect(
        text,
        startsWith(type.name.startsWith('debtAmount') ? 'El' : 'Ana'),
      );
    }
    final plain = LedgerEntry(
      id: 'l',
      orderId: 'o',
      type: LedgerEventType.debtAdded,
      actorId: 'a',
      at: t0,
    );
    expect(LedgerEntryText.of(plain, actor: 'Tú'), 'Tú agregó a alguien');
    expect(
      LedgerEntryText.of(
        plain.copyWith(
          type: LedgerEventType.orderTotalChanged,
          amountBefore: const Money(100),
          amountAfter: const Money(200),
        ),
        actor: 'Ana',
      ),
      r'Ana cambió el total: $1.00 → $2.00',
    );
  });
}
