import 'package:fino/features/teams/domain/enums/team_change_kind.dart';
import 'package:fino/features/teams/domain/failures/team_failure_reason.dart';
import 'package:fino/features/teams/domain/use_cases/refresh_member_profile.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/team_fixtures.dart';
import 'support/team_matchers.dart';

void main() {
  RefreshMemberProfile refresh() => const RefreshMemberProfile();

  test('a changed name or photo updates the member (U2)', () {
    final change = refresh()(
      userId: 'ana',
      roster: roster,
      displayName: ' Ana García ',
      photoUrl: 'http://x/a.png',
    );

    expect(change.kind, TeamChangeKind.profileUpdated);
    expect(change.teamId, 't1');
    expect(change.members.single.displayName, 'Ana García');
    expect(change.members.single.photoUrl, 'http://x/a.png');
  });

  test('the same profile is a no-op', () {
    final change = refresh()(userId: 'ana', roster: roster, displayName: 'ana');

    expect(change.isEmpty, isTrue);
  });

  test('rejects strangers and unusable names', () {
    expect(
      () => refresh()(userId: 'zoe', roster: roster, displayName: 'Zoe'),
      throwsTeam(TeamFailureReason.notMember),
    );
    for (final name in ['  ', 'x' * 81]) {
      expect(
        () => refresh()(userId: 'ana', roster: roster, displayName: name),
        throwsTeam(TeamFailureReason.invalidName),
      );
    }
  });
}
