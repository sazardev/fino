// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demo_data_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Keeps the demo data in place: whenever someone is signed in (also after
/// signing out wiped the database), the sample data is written again.
/// Does nothing unless the flavor asks for a demo session.

@ProviderFor(demoData)
final demoDataProvider = DemoDataProvider._();

/// Keeps the demo data in place: whenever someone is signed in (also after
/// signing out wiped the database), the sample data is written again.
/// Does nothing unless the flavor asks for a demo session.

final class DemoDataProvider extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
  /// Keeps the demo data in place: whenever someone is signed in (also after
  /// signing out wiped the database), the sample data is written again.
  /// Does nothing unless the flavor asks for a demo session.
  DemoDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'demoDataProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$demoDataHash();

  @$internal
  @override
  $ProviderElement<void> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  void create(Ref ref) {
    return demoData(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$demoDataHash() => r'b112958cef3adb47b4cb2120f50f8d14cfb7f832';
