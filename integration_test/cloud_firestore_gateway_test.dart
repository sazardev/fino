import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fino/bootstrap/connect_firebase_emulators.dart';
import 'package:fino/core/database/outbox_operation.dart';
import 'package:fino/core/flavor/configs/dev_flavor_config.dart';
import 'package:fino/core/sync/remote_failure.dart';
import 'package:fino/core/sync/remote_failure_kind.dart';
import 'package:fino/core/sync/remote_marker.dart';
import 'package:fino/core/sync/remote_write.dart';
import 'package:fino/core/sync/sdk/cloud_firestore_gateway.dart';
import 'package:fino/features/auth/data/fake_google_identity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

/// El gateway del SDK contra los emuladores reales, en un dispositivo o
/// navegador (el SDK no corre en `flutter test`). Necesita `tool/emulators.sh`;
/// se omite si no están arriba.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('commits atomically, reads, watches and maps failures', (
    tester,
  ) async {
    final emulators = devFlavorConfig.emulators!;
    try {
      final socket = await Socket.connect(
        emulators.host,
        emulators.firestorePort,
        timeout: const Duration(seconds: 1),
      );
      await socket.close();
    } on Object {
      markTestSkipped('Firebase emulators are not running');
      return;
    }

    await Firebase.initializeApp(options: devFlavorConfig.firebaseOptions);
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: false,
    );
    await connectFirebaseEmulators(emulators);
    final credential = await FirebaseAuth.instance.signInWithCredential(
      GoogleAuthProvider.credential(
        idToken: const FakeGoogleIdentity().idToken,
      ),
    );
    final uid = credential.user!.uid;
    final gateway = CloudFirestoreGateway(FirebaseFirestore.instance);
    final base = 'users/$uid/notes';
    final id = 'n${DateTime.now().microsecondsSinceEpoch}';

    // Lote atómico: crea, edita y borra campos con marcadores.
    await gateway.commit([
      RemoteWrite(
        collection: base,
        id: id,
        operation: OutboxOperation.create,
        fields: {
          'text': 'hola',
          'at': DateTime.utc(2026, 10, 6),
          'created': RemoteMarker.serverTimestamp,
        },
      ),
    ]);
    final doc = await gateway.get('$base/$id');
    expect(doc!.fields['text'], 'hola');
    expect(doc.fields['at'], DateTime.utc(2026, 10, 6));
    expect(doc.fields['created'], isA<DateTime>());

    // Escucha: instantánea inicial y después el cambio.
    final snapshots = gateway.watchCollection(base).take(2).toList();
    await Future<void>.delayed(const Duration(milliseconds: 300));
    await gateway.commit([
      RemoteWrite(
        collection: base,
        id: id,
        operation: OutboxOperation.update,
        fields: const {'text': 'adiós', 'created': RemoteMarker.fieldDelete},
      ),
    ]);
    final seen = await snapshots.timeout(const Duration(seconds: 10));
    expect(seen.first.isInitial, isTrue);
    expect(seen.last.changes.single.document.fields['text'], 'adiós');

    // Atomicidad: una escritura rechazada deshace la anterior.
    await expectLater(
      gateway.commit([
        RemoteWrite(
          collection: base,
          id: '${id}b',
          operation: OutboxOperation.create,
          fields: const {'text': 'no debe quedar'},
        ),
        const RemoteWrite(
          collection: 'teams/ajeno/orders',
          id: 'x',
          operation: OutboxOperation.create,
          fields: {'total': 1},
        ),
      ]),
      throwsA(
        isA<RemoteFailure>().having(
          (e) => e.kind,
          'kind',
          RemoteFailureKind.permissionDenied,
        ),
      ),
    );
    expect(await gateway.get('$base/${id}b'), isNull);
  });
}
