// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_user_id_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// El uid de quien está en sesión (`null` = nadie), para quien lo necesite
/// sin conocer de dónde viene la sesión. La app lo sobrescribe con el estado
/// de autenticación.

@ProviderFor(sessionUserId)
final sessionUserIdProvider = SessionUserIdProvider._();

/// El uid de quien está en sesión (`null` = nadie), para quien lo necesite
/// sin conocer de dónde viene la sesión. La app lo sobrescribe con el estado
/// de autenticación.

final class SessionUserIdProvider
    extends $FunctionalProvider<String?, String?, String?>
    with $Provider<String?> {
  /// El uid de quien está en sesión (`null` = nadie), para quien lo necesite
  /// sin conocer de dónde viene la sesión. La app lo sobrescribe con el estado
  /// de autenticación.
  SessionUserIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionUserIdProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionUserIdHash();

  @$internal
  @override
  $ProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String? create(Ref ref) {
    return sessionUserId(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$sessionUserIdHash() => r'3be7472a12d374a2df24c38c511665464a8b5686';
