// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demo_data_seeder_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(demoDataSeeder)
final demoDataSeederProvider = DemoDataSeederProvider._();

final class DemoDataSeederProvider
    extends $FunctionalProvider<DemoDataSeeder, DemoDataSeeder, DemoDataSeeder>
    with $Provider<DemoDataSeeder> {
  DemoDataSeederProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'demoDataSeederProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$demoDataSeederHash();

  @$internal
  @override
  $ProviderElement<DemoDataSeeder> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DemoDataSeeder create(Ref ref) {
    return demoDataSeeder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DemoDataSeeder value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DemoDataSeeder>(value),
    );
  }
}

String _$demoDataSeederHash() => r'25e25cafd3fba4c70b1dc6dd426579098d3d31b2';
