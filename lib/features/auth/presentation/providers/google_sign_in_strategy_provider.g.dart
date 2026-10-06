// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_sign_in_strategy_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(googleSignInStrategy)
final googleSignInStrategyProvider = GoogleSignInStrategyProvider._();

final class GoogleSignInStrategyProvider
    extends
        $FunctionalProvider<
          GoogleSignInStrategy,
          GoogleSignInStrategy,
          GoogleSignInStrategy
        >
    with $Provider<GoogleSignInStrategy> {
  GoogleSignInStrategyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'googleSignInStrategyProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$googleSignInStrategyHash();

  @$internal
  @override
  $ProviderElement<GoogleSignInStrategy> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GoogleSignInStrategy create(Ref ref) {
    return googleSignInStrategy(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoogleSignInStrategy value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoogleSignInStrategy>(value),
    );
  }
}

String _$googleSignInStrategyHash() =>
    r'bd40f858bc4b2e9d82413e3624d3625aaf294d2c';
