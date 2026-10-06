import 'package:fino/core/directory/directory_payout.dart';
import 'package:fino/core/directory/directory_person.dart';
import 'package:fino/core/directory/directory_team.dart';
import 'package:fino/core/directory/local_people_directory.dart';
import 'package:fino/core/directory/person_label.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/seed_fino.dart';
import '../../support/test_overrides.dart';

void main() {
  group('PersonLabel', () {
    const ana = DirectoryPerson(
      teamId: 't1',
      userId: 'u2',
      displayName: 'Ana García',
    );
    final people = {ana.key: ana};

    test('me, someone known, someone not yet downloaded', () {
      String of(String id) =>
          PersonLabel.of(people, teamId: 't1', userId: id, me: 'u1');

      expect(of('u1'), 'Tú');
      expect(of('u2'), 'Ana García');
      expect(of('u9'), 'Alguien');
      expect(PersonLabel.first('Ana García'), 'Ana');
    });
  });

  test('values compare by content', () {
    const a = DirectoryPerson(teamId: 't', userId: 'u', displayName: 'A');
    expect(
      a,
      const DirectoryPerson(teamId: 't', userId: 'u', displayName: 'A'),
    );
    expect(a.hashCode, isNot(0));
    const team = DirectoryTeam(id: 't', name: 'T', adminId: 'u');
    expect(team, const DirectoryTeam(id: 't', name: 'T', adminId: 'u'));
    expect(team.hashCode, isNot(0));
    const payout = DirectoryPayout(isClabe: true, number: '012180000112345671');
    expect(payout.grouped, '0121 8000 0112 3456 71');
    expect(payout.last4, '5671');
    expect(
      payout,
      const DirectoryPayout(isClabe: true, number: '012180000112345671'),
    );
    expect(payout.hashCode, isNot(0));
  });

  test('the local directory reads teams, people and visible payouts', () async {
    final db = testDatabase();
    addTearDown(db.close);
    await seedFino(db);
    final directory = LocalPeopleDirectory(db);

    final teams = await directory.watchTeams('u1').first;
    final people = await directory.watchPeople().first;
    final payout = await directory.watchPayout('t1', 'u2').first;

    expect(teams.single.name, 'Oficina');
    expect(teams.single.adminId, 'u1');
    expect(
      people.map((p) => p.displayName),
      containsAll(['Ana', 'Beto', 'Carla']),
    );
    expect(people.firstWhere((p) => p.userId == 'u1').isAdmin, isTrue);
    expect(payout!.isClabe, isTrue);
    expect(payout.bankName, 'BBVA');
    expect(await directory.watchPayout('t1', 'zz').first, isNull);
  });
}
