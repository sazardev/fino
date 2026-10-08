// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'draft_team_id_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// El equipo del pedido en captura: el elegido o, si no se ha elegido, el
/// primero (con un solo equipo no hay nada que elegir).

@ProviderFor(draftTeamId)
final draftTeamIdProvider = DraftTeamIdProvider._();

/// El equipo del pedido en captura: el elegido o, si no se ha elegido, el
/// primero (con un solo equipo no hay nada que elegir).

final class DraftTeamIdProvider
    extends $FunctionalProvider<String?, String?, String?>
    with $Provider<String?> {
  /// El equipo del pedido en captura: el elegido o, si no se ha elegido, el
  /// primero (con un solo equipo no hay nada que elegir).
  DraftTeamIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'draftTeamIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$draftTeamIdHash();

  @$internal
  @override
  $ProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String? create(Ref ref) {
    return draftTeamId(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$draftTeamIdHash() => r'71cd563d5e059c24ed7cc71b5966b698fd8cb686';
