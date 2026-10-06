import 'package:flutter_test/flutter_test.dart';

import 'support/firestore_rest.dart';
import 'support/rules_emulator.dart';
import 'support/rules_matchers.dart';
import 'support/rules_world.dart';

void main() {
  if (skipWithoutRulesEmulator()) return;

  late FirestoreRest db;
  late RulesWorld w;

  setUpAll(() => db = FirestoreRest.fromEnvironment());
  setUp(() async => w = await RulesWorld.seed(db));

  group('creating a team', () {
    List<Write> create(
      String uid,
      String teamId,
      String code, {
      String role = 'admin',
    }) => [
      Write.create('teams/$teamId', {
        'name': 'Nuevo',
        'adminId': uid,
        'inviteCode': code,
        'memberIds': [uid],
        'createdAt': const ServerTime(),
      }),
      Write.create('teams/$teamId/members/$uid', {
        'userId': uid,
        'role': role,
        'joinedAt': const ServerTime(),
        'displayName': 'Zoe',
      }),
      Write.create('invites/$code', {'teamId': teamId, 'teamName': 'Nuevo'}),
    ];

    test('the creator becomes the only member and admin', () async {
      expect(
        await w.as('zoe', create('zoe', 'zoeTeam1', 'ZOECODE1')),
        isAllowed,
      );
    });

    test('cannot create a team naming someone else as admin', () async {
      final writes = create('zoe', 'zoeTeam2', 'ZOECODE2');
      writes[0] = const Write.create('teams/zoeTeam2', {
        'name': 'Nuevo',
        'adminId': 'ana',
        'inviteCode': 'ZOECODE2',
        'memberIds': ['zoe'],
        'createdAt': ServerTime(),
      });
      expect(await w.as('zoe', writes), isDenied);
    });

    test('needs a session', () async {
      expect(
        await db.commit(null, create('zoe', 'zoeTeam3', 'ZOECODE3')),
        isDenied,
      );
    });
  });

  group('reading', () {
    test('members read the team and their teammates', () async {
      expect(await w.read('ana', 'teams/${w.teamId}'), isAllowed);
      expect(await w.read('ana', w.path('members/beto')), isAllowed);
    });

    test('outsiders and signed-out users read nothing', () async {
      expect(await w.read('zoe', 'teams/${w.teamId}'), isDenied);
      expect(await w.read('zoe', w.path('members/ana')), isDenied);
      expect(await w.read(null, 'teams/${w.teamId}'), isDenied);
    });

    test('a person discovers only their own memberships', () async {
      final mine = await db.collectionGroup(
        FirestoreRest.tokenFor('ana'),
        'members',
        'userId',
        'ana',
      );
      final theirs = await db.collectionGroup(
        FirestoreRest.tokenFor('ana'),
        'members',
        'userId',
        'beto',
      );
      expect(mine, isAllowed);
      expect(theirs, isDenied);
    });
  });

  group('joining with an invite code (E2, E4)', () {
    List<Write> join(String uid, {String? code, bool bumpTeam = true}) => [
      Write.create(w.path('members/$uid'), {
        'userId': uid,
        'role': 'member',
        'joinedAt': const ServerTime(),
        'displayName': 'Zoe',
        'inviteCode': code ?? w.inviteCode,
      }),
      if (bumpTeam)
        Write.update('teams/${w.teamId}', {
          'memberIds': ArrayUnion([uid]),
        }),
    ];

    test('a signed-in person with a valid code joins', () async {
      expect(await w.as('zoe', join('zoe')), isAllowed);
      expect(await w.read('zoe', 'teams/${w.teamId}'), isAllowed);
    });

    test('a wrong code is refused', () async {
      expect(await w.as('zoe', join('zoe', code: 'NOPE0000')), isDenied);
    });

    test(
      'creating the member without listing them in the team is refused',
      () async {
        expect(await w.as('zoe', join('zoe', bumpTeam: false)), isDenied);
      },
    );

    test(
      'adding yourself to the team without a member doc is refused',
      () async {
        expect(await w.as('zoe', [join('zoe')[1]]), isDenied);
      },
    );

    test('cannot join as admin', () async {
      final writes = join('zoe');
      writes[0] = Write.create(w.path('members/zoe'), {
        'userId': 'zoe',
        'role': 'admin',
        'joinedAt': const ServerTime(),
        'displayName': 'Zoe',
        'inviteCode': w.inviteCode,
      });
      expect(await w.as('zoe', writes), isDenied);
    });

    test('cannot bring someone else in', () async {
      expect(
        await w.as('zoe', [
          Write.create(w.path('members/mia'), {
            'userId': 'mia',
            'role': 'member',
            'joinedAt': const ServerTime(),
            'displayName': 'Mia',
            'inviteCode': w.inviteCode,
          }),
          Write.update('teams/${w.teamId}', {
            'memberIds': const ArrayUnion(['mia']),
          }),
        ]),
        isDenied,
      );
    });

    test('an existing member cannot join twice', () async {
      expect(await w.as('ana', join('ana')), isDenied);
    });

    test('the invite is readable by id but never listable', () async {
      expect(await w.read('zoe', 'invites/${w.inviteCode}'), isAllowed);
      expect(await w.read(null, 'invites/${w.inviteCode}'), isDenied);
      expect(await db.list(FirestoreRest.tokenFor('zoe'), 'invites'), isDenied);
    });
  });

  group('leaving and expelling (4.2)', () {
    List<Write> remove(String uid, {required String by}) => [
      Write.remove(w.path('members/$uid')),
      Write.update('teams/${w.teamId}', {
        'memberIds': ArrayRemove([uid]),
      }),
    ];

    test('a member can leave', () async {
      expect(await w.as('ana', remove('ana', by: 'ana')), isAllowed);
      expect(await w.read('ana', 'teams/${w.teamId}'), isDenied);
    });

    test('the admin cannot leave (E6)', () async {
      expect(await w.as('omar', remove('omar', by: 'omar')), isDenied);
    });

    test('the admin expels a member', () async {
      expect(await w.as('omar', remove('ana', by: 'omar')), isAllowed);
    });

    test('a member cannot expel another', () async {
      expect(await w.as('ana', remove('beto', by: 'ana')), isDenied);
    });

    test(
      'removing the member doc without updating the team is refused',
      () async {
        expect(
          await w.as('ana', [Write.remove(w.path('members/ana'))]),
          isDenied,
        );
      },
    );
  });

  group('administration (E3, E5, E6)', () {
    test('the admin renames the team and regenerates the code', () async {
      expect(
        await w.as('omar', [
          Write.update('teams/${w.teamId}', {
            'name': 'Otra',
            'inviteCode': 'N${w.id}',
          }),
          Write.remove('invites/${w.inviteCode}'),
          Write.create('invites/N${w.id}', {
            'teamId': w.teamId,
            'teamName': 'Otra',
          }),
        ]),
        isAllowed,
      );
    });

    test('a member cannot rename or regenerate', () async {
      expect(
        await w.as('ana', [
          Write.update('teams/${w.teamId}', {'name': 'Hack'}),
        ]),
        isDenied,
      );
      expect(
        await w.as('ana', [Write.remove('invites/${w.inviteCode}')]),
        isDenied,
      );
    });

    test('an invite cannot point at a team you do not administer', () async {
      expect(
        await w.as('zoe', [
          Write.create('invites/STEAL000', {'teamId': w.teamId}),
        ]),
        isDenied,
      );
    });

    test('the admin transfers the role keeping roles consistent', () async {
      expect(
        await w.as('omar', [
          Write.update('teams/${w.teamId}', {'adminId': 'ana'}),
          Write.update(w.path('members/ana'), {'role': 'admin'}),
          Write.update(w.path('members/omar'), {'role': 'member'}),
        ]),
        isAllowed,
      );
    });

    test(
      'promoting a member without transferring the team is refused',
      () async {
        expect(
          await w.as('omar', [
            Write.update(w.path('members/ana'), {'role': 'admin'}),
          ]),
          isDenied,
        );
      },
    );

    test('a member cannot grant themselves admin', () async {
      expect(
        await w.as('ana', [
          Write.update(w.path('members/ana'), {'role': 'admin'}),
        ]),
        isDenied,
      );
    });

    test('members update only their own profile', () async {
      expect(
        await w.as('ana', [
          Write.update(w.path('members/ana'), {'displayName': 'Ana G'}),
        ]),
        isAllowed,
      );
      expect(
        await w.as('ana', [
          Write.update(w.path('members/beto'), {'displayName': 'Hack'}),
        ]),
        isDenied,
      );
    });

    test('only the admin deletes the team', () async {
      expect(await w.as('ana', [Write.remove('teams/${w.teamId}')]), isDenied);
      expect(
        await w.as('omar', [Write.remove('teams/${w.teamId}')]),
        isAllowed,
      );
      expect(await w.read('ana', w.path('members/beto')), isDenied);
    });
  });
}
