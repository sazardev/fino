// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_coordinator_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Mantiene sincronizado con Firestore a quien está en sesión.
///
/// Se enciende al iniciar sesión y se apaga al cerrarla. Nada en la app lo
/// necesita para funcionar sin conexión: Drift es la fuente de verdad. Una
/// sesión demo no sincroniza (sus datos de muestra solo existen en local).
/// La raíz de la app debe observarlo para que corra.

@ProviderFor(syncCoordinator)
final syncCoordinatorProvider = SyncCoordinatorProvider._();

/// Mantiene sincronizado con Firestore a quien está en sesión.
///
/// Se enciende al iniciar sesión y se apaga al cerrarla. Nada en la app lo
/// necesita para funcionar sin conexión: Drift es la fuente de verdad. Una
/// sesión demo no sincroniza (sus datos de muestra solo existen en local).
/// La raíz de la app debe observarlo para que corra.

final class SyncCoordinatorProvider
    extends
        $FunctionalProvider<
          SyncCoordinator?,
          SyncCoordinator?,
          SyncCoordinator?
        >
    with $Provider<SyncCoordinator?> {
  /// Mantiene sincronizado con Firestore a quien está en sesión.
  ///
  /// Se enciende al iniciar sesión y se apaga al cerrarla. Nada en la app lo
  /// necesita para funcionar sin conexión: Drift es la fuente de verdad. Una
  /// sesión demo no sincroniza (sus datos de muestra solo existen en local).
  /// La raíz de la app debe observarlo para que corra.
  SyncCoordinatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncCoordinatorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncCoordinatorHash();

  @$internal
  @override
  $ProviderElement<SyncCoordinator?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SyncCoordinator? create(Ref ref) {
    return syncCoordinator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncCoordinator? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncCoordinator?>(value),
    );
  }
}

String _$syncCoordinatorHash() => r'4a3ed449cd98cdab8fa10072767761cdf54eb3e4';
