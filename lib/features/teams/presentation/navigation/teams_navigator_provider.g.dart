// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teams_navigator_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Lo sobrescribe la app con su router (`appProviderOverrides`).

@ProviderFor(teamsNavigator)
final teamsNavigatorProvider = TeamsNavigatorProvider._();

/// Lo sobrescribe la app con su router (`appProviderOverrides`).

final class TeamsNavigatorProvider
    extends $FunctionalProvider<TeamsNavigator, TeamsNavigator, TeamsNavigator>
    with $Provider<TeamsNavigator> {
  /// Lo sobrescribe la app con su router (`appProviderOverrides`).
  TeamsNavigatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'teamsNavigatorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$teamsNavigatorHash();

  @$internal
  @override
  $ProviderElement<TeamsNavigator> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TeamsNavigator create(Ref ref) {
    return teamsNavigator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TeamsNavigator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TeamsNavigator>(value),
    );
  }
}

String _$teamsNavigatorHash() => r'0c73d63587a1f7d4fcab1d6a6995abd37c97d3d5';
