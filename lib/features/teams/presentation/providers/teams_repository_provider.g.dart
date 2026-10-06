// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teams_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(teamsRepository)
final teamsRepositoryProvider = TeamsRepositoryProvider._();

final class TeamsRepositoryProvider
    extends
        $FunctionalProvider<TeamsRepository, TeamsRepository, TeamsRepository>
    with $Provider<TeamsRepository> {
  TeamsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'teamsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$teamsRepositoryHash();

  @$internal
  @override
  $ProviderElement<TeamsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TeamsRepository create(Ref ref) {
    return teamsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TeamsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TeamsRepository>(value),
    );
  }
}

String _$teamsRepositoryHash() => r'839d15da394448ae6bd5799597943e0007bda9af';
