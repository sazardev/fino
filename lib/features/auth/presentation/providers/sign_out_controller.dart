import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/analytics/analytics_service_provider.dart';
import '../../../../core/analytics/events/signed_out.dart';
import '../../../../core/database/app_database_provider.dart';
import 'auth_repository_provider.dart';

part 'sign_out_controller.g.dart';

/// Signs out and wipes what the person left on this device.
@riverpod
class SignOutController extends _$SignOutController {
  @override
  FutureOr<void> build() {}

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(analyticsServiceProvider).log(const SignedOut());
      await ref.read(authRepositoryProvider).signOut();
      await ref.read(appDatabaseProvider).wipe();
    });
  }
}
