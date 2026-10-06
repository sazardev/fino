// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flavor_config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The running build's [FlavorConfig]; overridden once, in `bootstrap`.

@ProviderFor(flavorConfig)
final flavorConfigProvider = FlavorConfigProvider._();

/// The running build's [FlavorConfig]; overridden once, in `bootstrap`.

final class FlavorConfigProvider
    extends $FunctionalProvider<FlavorConfig, FlavorConfig, FlavorConfig>
    with $Provider<FlavorConfig> {
  /// The running build's [FlavorConfig]; overridden once, in `bootstrap`.
  FlavorConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'flavorConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$flavorConfigHash();

  @$internal
  @override
  $ProviderElement<FlavorConfig> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FlavorConfig create(Ref ref) {
    return flavorConfig(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FlavorConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FlavorConfig>(value),
    );
  }
}

String _$flavorConfigHash() => r'79f434cdbabb58efc7f2f1b8b950a3846056bbe6';
