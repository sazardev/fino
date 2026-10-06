import 'package:fino/features/teams/domain/entities/card_payout.dart';
import 'package:fino/features/teams/domain/entities/clabe_payout.dart';
import 'package:fino/features/teams/domain/failures/team_failure_reason.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/team_matchers.dart';

void main() {
  const validClabe = '012180000112345671';

  group('ClabePayout (M3)', () {
    test('accepts a CLABE with a valid check digit, ignoring separators', () {
      final method = ClabePayout.parse(
        '0121 8000-0112 3456 71',
        bankName: 'BBVA',
        holderName: 'Omar',
      );

      expect(method.clabe, validClabe);
      expect(method.last4, '5671');
      expect(method.bankName, 'BBVA');
      expect(method.holderName, 'Omar');
    });

    test('rejects a wrong check digit or length', () {
      expect(
        () => ClabePayout.parse('012180000112345672'),
        throwsTeam(TeamFailureReason.invalidClabe),
      );
      expect(
        () => ClabePayout.parse('1234'),
        throwsTeam(TeamFailureReason.invalidClabe),
      );
      expect(
        () => ClabePayout.parse('01218000011234567a'),
        throwsTeam(TeamFailureReason.invalidClabe),
      );
    });

    test('compares by value', () {
      expect(ClabePayout.parse(validClabe), ClabePayout.parse(validClabe));
      expect(
        ClabePayout.parse(validClabe),
        isNot(ClabePayout.parse(validClabe, bankName: 'BBVA')),
      );
      expect(
        ClabePayout.parse(validClabe).hashCode,
        ClabePayout.parse(validClabe).hashCode,
      );
    });
  });

  group('CardPayout (M1)', () {
    test('accepts 16 digits plus a bank', () {
      final method = CardPayout.parse(
        '4152 3133-1234 5678',
        bankName: ' BBVA ',
      );

      expect(method.cardNumber, '4152313312345678');
      expect(method.last4, '5678');
      expect(method.bankName, 'BBVA');
    });

    test('rejects a short number or a missing bank', () {
      expect(
        () => CardPayout.parse('1234', bankName: 'BBVA'),
        throwsTeam(TeamFailureReason.invalidCard),
      );
      expect(
        () => CardPayout.parse('4152313312345678', bankName: '  '),
        throwsTeam(TeamFailureReason.bankRequired),
      );
    });

    test('compares by value', () {
      CardPayout card() =>
          CardPayout.parse('4152313312345678', bankName: 'BBVA');

      expect(card(), card());
      expect(card().hashCode, card().hashCode);
      expect(card(), isNot(ClabePayout.parse(validClabe)));
    });
  });
}
