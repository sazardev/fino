// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'draft_split_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// El reparto del pedido en captura, calculado con las mismas reglas que
/// usará al guardarse (SPEC §5.2): lo que se ve es lo que se guarda.

@ProviderFor(draftSplit)
final draftSplitProvider = DraftSplitProvider._();

/// El reparto del pedido en captura, calculado con las mismas reglas que
/// usará al guardarse (SPEC §5.2): lo que se ve es lo que se guarda.

final class DraftSplitProvider
    extends $FunctionalProvider<DraftSplit, DraftSplit, DraftSplit>
    with $Provider<DraftSplit> {
  /// El reparto del pedido en captura, calculado con las mismas reglas que
  /// usará al guardarse (SPEC §5.2): lo que se ve es lo que se guarda.
  DraftSplitProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'draftSplitProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$draftSplitHash();

  @$internal
  @override
  $ProviderElement<DraftSplit> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DraftSplit create(Ref ref) {
    return draftSplit(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DraftSplit value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DraftSplit>(value),
    );
  }
}

String _$draftSplitHash() => r'010a06bb494aff729083d330e9ea728709d48ba4';
