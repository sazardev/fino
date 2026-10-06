// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// El perfil de quien está en sesión (`null` = nadie). La app lo sobrescribe
/// con el estado de autenticación.

@ProviderFor(sessionProfile)
final sessionProfileProvider = SessionProfileProvider._();

/// El perfil de quien está en sesión (`null` = nadie). La app lo sobrescribe
/// con el estado de autenticación.

final class SessionProfileProvider
    extends
        $FunctionalProvider<SessionProfile?, SessionProfile?, SessionProfile?>
    with $Provider<SessionProfile?> {
  /// El perfil de quien está en sesión (`null` = nadie). La app lo sobrescribe
  /// con el estado de autenticación.
  SessionProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionProfileProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionProfileHash();

  @$internal
  @override
  $ProviderElement<SessionProfile?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SessionProfile? create(Ref ref) {
    return sessionProfile(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SessionProfile? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SessionProfile?>(value),
    );
  }
}

String _$sessionProfileHash() => r'f5fb21ad0846206c9ee56df9e2a138c3ed4a0bb9';
