// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Runs the Google sign-in; its state is the sign-in button's busy/error state.

@ProviderFor(SignInController)
final signInControllerProvider = SignInControllerProvider._();

/// Runs the Google sign-in; its state is the sign-in button's busy/error state.
final class SignInControllerProvider
    extends $AsyncNotifierProvider<SignInController, void> {
  /// Runs the Google sign-in; its state is the sign-in button's busy/error state.
  SignInControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signInControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signInControllerHash();

  @$internal
  @override
  SignInController create() => SignInController();
}

String _$signInControllerHash() => r'5a0205de5e4962e668e5d3d7b3a1cc7b32cb4eca';

/// Runs the Google sign-in; its state is the sign-in button's busy/error state.

abstract class _$SignInController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
