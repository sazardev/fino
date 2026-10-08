// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_check_activator_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appCheckActivator)
final appCheckActivatorProvider = AppCheckActivatorProvider._();

final class AppCheckActivatorProvider
    extends
        $FunctionalProvider<
          AppCheckActivator,
          AppCheckActivator,
          AppCheckActivator
        >
    with $Provider<AppCheckActivator> {
  AppCheckActivatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appCheckActivatorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appCheckActivatorHash();

  @$internal
  @override
  $ProviderElement<AppCheckActivator> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppCheckActivator create(Ref ref) {
    return appCheckActivator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppCheckActivator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppCheckActivator>(value),
    );
  }
}

String _$appCheckActivatorHash() => r'27f63ee7274fd3f7941bbacffd04daf98f65b087';
