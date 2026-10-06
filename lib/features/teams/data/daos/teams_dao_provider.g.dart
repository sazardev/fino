// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teams_dao_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(teamsDao)
final teamsDaoProvider = TeamsDaoProvider._();

final class TeamsDaoProvider
    extends $FunctionalProvider<TeamsDao, TeamsDao, TeamsDao>
    with $Provider<TeamsDao> {
  TeamsDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'teamsDaoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$teamsDaoHash();

  @$internal
  @override
  $ProviderElement<TeamsDao> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TeamsDao create(Ref ref) {
    return teamsDao(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TeamsDao value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TeamsDao>(value),
    );
  }
}

String _$teamsDaoHash() => r'016ae50b2493efa6e9ff742a17c697c4de55c607';
