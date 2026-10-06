// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_plugins_supported_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Overridable so tests can exercise the Linux paths from any host.

@ProviderFor(firebasePluginsSupportedFlag)
final firebasePluginsSupportedFlagProvider =
    FirebasePluginsSupportedFlagProvider._();

/// Overridable so tests can exercise the Linux paths from any host.

final class FirebasePluginsSupportedFlagProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Overridable so tests can exercise the Linux paths from any host.
  FirebasePluginsSupportedFlagProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firebasePluginsSupportedFlagProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firebasePluginsSupportedFlagHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return firebasePluginsSupportedFlag(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$firebasePluginsSupportedFlagHash() =>
    r'15d5382d8b7d99f849f8ed5808175db739340279';
