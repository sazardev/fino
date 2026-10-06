// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_out_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Signs out and wipes what the person left on this device.

@ProviderFor(SignOutController)
final signOutControllerProvider = SignOutControllerProvider._();

/// Signs out and wipes what the person left on this device.
final class SignOutControllerProvider
    extends $AsyncNotifierProvider<SignOutController, void> {
  /// Signs out and wipes what the person left on this device.
  SignOutControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signOutControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signOutControllerHash();

  @$internal
  @override
  SignOutController create() => SignOutController();
}

String _$signOutControllerHash() => r'fa03c707328f1e251820990902f23cbe0ff4ca67';

/// Signs out and wipes what the person left on this device.

abstract class _$SignOutController extends $AsyncNotifier<void> {
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
