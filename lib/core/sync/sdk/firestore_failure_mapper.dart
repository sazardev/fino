import 'package:firebase_core/firebase_core.dart';

import '../remote_failure.dart';
import '../remote_failure_kind.dart';

/// Errores del SDK → [RemoteFailure].
abstract final class FirestoreFailureMapper {
  static RemoteFailure map(Object error) {
    if (error is RemoteFailure) return error;
    if (error is FirebaseException) {
      return RemoteFailure(kindOf(error.code), error.message ?? error.code);
    }
    return RemoteFailure(RemoteFailureKind.other, '$error');
  }

  static RemoteFailureKind kindOf(String code) => switch (code) {
    'permission-denied' => RemoteFailureKind.permissionDenied,
    'not-found' => RemoteFailureKind.notFound,
    'already-exists' => RemoteFailureKind.alreadyExists,
    'unauthenticated' => RemoteFailureKind.unauthenticated,
    'unavailable' ||
    'deadline-exceeded' ||
    'aborted' ||
    'resource-exhausted' ||
    'cancelled' => RemoteFailureKind.unavailable,
    _ => RemoteFailureKind.other,
  };
}
