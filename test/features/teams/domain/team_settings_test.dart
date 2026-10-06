import 'dart:math';

import 'package:fino/features/teams/domain/entities/clabe_payout.dart';
import 'package:fino/features/teams/domain/entities/invite_codes.dart';
import 'package:fino/features/teams/domain/entities/live_debts.dart';
import 'package:fino/features/teams/domain/failures/team_failure.dart';
import 'package:fino/features/teams/domain/failures/team_failure_reason.dart';
import 'package:fino/features/teams/domain/use_cases/payout_method_access.dart';
import 'package:fino/features/teams/domain/use_cases/set_payout_method.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/team_fixtures.dart';
import 'support/team_matchers.dart';

void main() {
  group('SetPayoutMethod (M1)', () {
    final method = ClabePayout.parse('012180000112345671');

    test('a member sets or replaces their payout method', () {
      final change = const SetPayoutMethod()(
        userId: 'ana',
        roster: roster,
        method: method,
      );

      expect(change.members.single.payoutMethod, method);
      expect(change.members.single.userId, 'ana');
    });

    test('a stranger cannot', () {
      expect(
        () => const SetPayoutMethod()(
          userId: 'zoe',
          roster: roster,
          method: method,
        ),
        throwsTeam(TeamFailureReason.notMember),
      );
    });
  });

  group('PayoutMethodAccess (M4)', () {
    bool canView({String viewer = 'ana', bool live = false}) =>
        PayoutMethodAccess.canView(
          viewerId: viewer,
          ownerId: 'omar',
          viewerHasLiveDebtToOwner: live,
        );

    test('the owner and whoever owes them can see it; nobody else', () {
      expect(canView(viewer: 'omar'), isTrue);
      expect(canView(live: true), isTrue);
      expect(canView(), isFalse);
    });
  });

  group('InviteCodes', () {
    test('generates unambiguous 8-character codes', () {
      final code = InviteCodes.generate(_Counter());

      expect(code, hasLength(InviteCodes.length));
      expect(code.split('').every(InviteCodes.alphabet.contains), isTrue);
    });

    test('normalizes case, spaces and dashes', () {
      expect(InviteCodes.normalize(' ab-cd 23 '), 'ABCD23');
    });
  });

  test('live debts compare by value', () {
    expect(const LiveDebts(asDebtor: 1), const LiveDebts(asDebtor: 1));
    expect(
      const LiveDebts(asDebtor: 1).hashCode,
      const LiveDebts(asDebtor: 1).hashCode,
    );
    expect(LiveDebts.none.hasAny, isFalse);
  });

  test('roster answers membership questions', () {
    expect(roster.size, 3);
    expect(roster.memberIds, {'omar', 'ana', 'beto'});
    expect(roster.admins.single.userId, 'omar');
    expect(roster.isAdmin('ana'), isFalse);
  });

  test('team failure describes itself', () {
    expect(
      const TeamFailure(TeamFailureReason.notAdmin).toString(),
      'TeamFailure(notAdmin)',
    );
  });
}

class _Counter implements Random {
  var _n = 0;

  @override
  int nextInt(int max) => _n++ % max;

  @override
  bool nextBool() => false;

  @override
  double nextDouble() => 0;
}
