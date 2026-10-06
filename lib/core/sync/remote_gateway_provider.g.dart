// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_gateway_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// La puerta a Firestore: el SDK donde existe (Android, web) y REST contra el
/// emulador donde no (Linux).

@ProviderFor(remoteGateway)
final remoteGatewayProvider = RemoteGatewayProvider._();

/// La puerta a Firestore: el SDK donde existe (Android, web) y REST contra el
/// emulador donde no (Linux).

final class RemoteGatewayProvider
    extends $FunctionalProvider<RemoteGateway, RemoteGateway, RemoteGateway>
    with $Provider<RemoteGateway> {
  /// La puerta a Firestore: el SDK donde existe (Android, web) y REST contra el
  /// emulador donde no (Linux).
  RemoteGatewayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remoteGatewayProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remoteGatewayHash();

  @$internal
  @override
  $ProviderElement<RemoteGateway> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RemoteGateway create(Ref ref) {
    return remoteGateway(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RemoteGateway value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RemoteGateway>(value),
    );
  }
}

String _$remoteGatewayHash() => r'b5ec572b86cddef5fff57bf07b9c6ed860fff9fc';
