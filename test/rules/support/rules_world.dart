import 'dart:math';

import 'firestore_rest.dart';

final seededAt = DateTime.utc(2026, 10, 6, 12);

final _random = Random.secure();
const _alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';

/// Un equipo sembrado (saltándose las reglas) para probar una escena.
///
/// Cada mundo usa ids propios: los tests no se pisan entre sí.
class RulesWorld {
  new _(this.db, this.id) : teamId = 'team$id', inviteCode = 'T$id';

  final FirestoreRest db;

  /// 7 caracteres al azar: los archivos de prueba corren en paralelo sobre el
  /// mismo emulador y no deben pisarse.
  final String id;
  final String teamId;
  final String inviteCode;

  /// El equipo: `omar` admin; `ana`, `beto` y `cris` miembros; `omar` con
  /// método de cobro.
  static Future<RulesWorld> seed(FirestoreRest db) async {
    final world = RulesWorld._(
      db,
      String.fromCharCodes([
        for (var i = 0; i < 7; i++)
          _alphabet.codeUnitAt(_random.nextInt(_alphabet.length)),
      ]),
    );
    await world.owner([
      Write.create('teams/${world.teamId}', {
        'name': 'Oficina',
        'adminId': 'omar',
        'inviteCode': world.inviteCode,
        'memberIds': ['omar', 'ana', 'beto', 'cris'],
        'createdAt': seededAt,
      }),
      Write.create('invites/${world.inviteCode}', {
        'teamId': world.teamId,
        'teamName': 'Oficina',
      }),
      for (final uid in ['omar', 'ana', 'beto', 'cris'])
        Write.create('teams/${world.teamId}/members/$uid', {
          'userId': uid,
          'role': uid == 'omar' ? 'admin' : 'member',
          'joinedAt': seededAt,
          'displayName': uid,
        }),
      Write.create('teams/${world.teamId}/members/omar/payout/main', {
        'type': 'clabe',
        'number': '012180000112345671',
      }),
    ]);
    return world;
  }

  String path(String sub) => 'teams/$teamId/$sub';

  Future<RestResult> owner(List<Write> writes) => db.commit('owner', writes);

  Future<RestResult> as(String uid, List<Write> writes) =>
      db.commit(FirestoreRest.tokenFor(uid), writes);

  Future<RestResult> read(String? uid, String path) =>
      db.get(uid == null ? null : FirestoreRest.tokenFor(uid), path);

  // ------------------------------------------------------------- siembra
  Future<void> seedOrder(String orderId, {String creditor = 'omar'}) => owner([
    Write.create(path('orders/$orderId'), {
      'creditorId': creditor,
      'concept': 'Café',
      'total': 30000,
      'spentAt': seededAt,
      'createdAt': seededAt,
      'updatedAt': seededAt,
    }),
  ]);

  Future<void> seedDebt(
    String debtId, {
    String orderId = 'o1',
    String debtor = 'ana',
    String status = 'pending',
    String? paymentId,
    int amount = 6000,
  }) => owner([
    Write.create(path('debts/$debtId'), {
      'orderId': orderId,
      'creditorId': 'omar',
      'debtorId': debtor,
      'amount': amount,
      'status': status,
      'createdAt': seededAt,
      'updatedAt': seededAt,
      'paymentId': ?paymentId,
    }),
  ]);

  Future<void> seedPayment(
    String paymentId,
    List<String> debtIds, {
    String debtor = 'ana',
  }) => owner([
    Write.create(
      path('payments/$paymentId'),
      paymentData(debtor, debtIds, seed: true),
    ),
  ]);

  // ---------------------------------------------------------- datos válidos
  Map<String, Object?> orderData({
    String creditor = 'omar',
    int total = 30000,
  }) => {
    'creditorId': creditor,
    'concept': 'Café',
    'total': total,
    'spentAt': seededAt,
    'createdAt': const ServerTime(),
    'updatedAt': const ServerTime(),
  };

  Map<String, Object?> debtData(
    String orderId,
    String debtor, {
    int amount = 6000,
  }) => {
    'orderId': orderId,
    'creditorId': 'omar',
    'debtorId': debtor,
    'amount': amount,
    'status': 'pending',
    'createdAt': const ServerTime(),
    'updatedAt': const ServerTime(),
  };

  Map<String, Object?> paymentData(
    String debtor,
    List<String> debtIds, {
    bool seed = false,
  }) => {
    'creditorId': 'omar',
    'debtorId': debtor,
    'debtIds': debtIds,
    'payoutShown': {'bankName': 'BBVA', 'last4': '5671'},
    'reportedAt': seed ? seededAt : const ServerTime(),
    'awaitingConfirmationReminderSent': false,
  };

  Map<String, Object?> ledgerData(
    String actor, {
    String type = 'debtAdded',
    bool? confidential,
  }) => {
    'orderId': 'o1',
    'type': type,
    'actorId': actor,
    'at': const ServerTime(),
    'confidential':
        confidential ?? (type == 'paymentReported' || type == 'debtObjected'),
    'partyIds': ['omar', 'ana'],
  };

  Map<String, Object?> inboxData(
    String actor, {
    String kind = 'orderDebtCreated',
  }) => {
    'kind': kind,
    'actorId': actor,
    'teamId': teamId,
    'targetType': 'debt',
    'targetId': 'd1',
    'createdAt': const ServerTime(),
  };
}
