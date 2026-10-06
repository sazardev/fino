import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/database/app_database_provider.dart';
import '../../core/flavor/flavor_config_provider.dart';
import '../../core/logging/app_logger_provider.dart';
import '../../core/session/session_user_id_provider.dart';
import '../../core/sync/remote_gateway_provider.dart';
import '../../core/time/clock_provider.dart';
import 'sync_coordinator.dart';

part 'sync_coordinator_provider.g.dart';

/// Mantiene sincronizado con Firestore a quien está en sesión.
///
/// Se enciende al iniciar sesión y se apaga al cerrarla. Nada en la app lo
/// necesita para funcionar sin conexión: Drift es la fuente de verdad. Una
/// sesión demo no sincroniza (sus datos de muestra solo existen en local).
/// La raíz de la app debe observarlo para que corra.
@Riverpod(keepAlive: true)
SyncCoordinator? syncCoordinator(Ref ref) {
  final userId = ref.watch(sessionUserIdProvider);
  if (userId == null || ref.watch(flavorConfigProvider).demoSession) {
    return null;
  }
  final coordinator = SyncCoordinator(
    db: ref.watch(appDatabaseProvider),
    gateway: ref.watch(remoteGatewayProvider),
    userId: userId,
    clock: ref.watch(clockProvider),
    logger: ref.watch(appLoggerProvider),
  )..start();
  ref.onDispose(coordinator.stop);
  return coordinator;
}
