import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/analytics/analytics_service_provider.dart';
import '../../../../core/analytics/events/signed_in.dart';
import 'auth_repository_provider.dart';

part 'sign_in_controller.g.dart';

/// Runs the Google sign-in; its state is the sign-in button's busy/error state.
@riverpod
class SignInController extends _$SignInController {
  @override
  FutureOr<void> build() {}

  Future<void> signIn() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).signInWithGoogle();
      await ref.read(analyticsServiceProvider).log(const SignedIn());
    });
  }
}
