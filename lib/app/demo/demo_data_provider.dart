import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/flavor/flavor_config_provider.dart';
import '../../features/auth/presentation/providers/auth_state_provider.dart';
import 'demo_data_seeder_provider.dart';

part 'demo_data_provider.g.dart';

/// Keeps the demo data in place: whenever someone is signed in (also after
/// signing out wiped the database), the sample data is written again.
/// Does nothing unless the flavor asks for a demo session.
@Riverpod(keepAlive: true)
void demoData(Ref ref) {
  if (!ref.watch(flavorConfigProvider).demoSession) return;

  ref.listen(authStateProvider, (_, auth) {
    final user = auth.value;
    if (user != null) unawaited(ref.read(demoDataSeederProvider).seed(user));
  }, fireImmediately: true);
}
