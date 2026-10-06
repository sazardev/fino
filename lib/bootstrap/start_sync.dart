import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/sync/sync_coordinator_provider.dart';

/// Deja corriendo la sincronización con Firestore mientras haya sesión.
///
/// Alguien debe escuchar al coordinador para que siga encendido y reaccione a
/// iniciar o cerrar sesión; la app no depende de él para funcionar offline.
void startSync(ProviderContainer container) {
  container.listen(syncCoordinatorProvider, (_, _) {}, fireImmediately: true);
}
