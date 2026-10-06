// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_teams_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Los equipos de quien está en sesión (vacío sin sesión).

@ProviderFor(myTeams)
final myTeamsProvider = MyTeamsProvider._();

/// Los equipos de quien está en sesión (vacío sin sesión).

final class MyTeamsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DirectoryTeam>>,
          List<DirectoryTeam>,
          Stream<List<DirectoryTeam>>
        >
    with
        $FutureModifier<List<DirectoryTeam>>,
        $StreamProvider<List<DirectoryTeam>> {
  /// Los equipos de quien está en sesión (vacío sin sesión).
  MyTeamsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myTeamsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myTeamsHash();

  @$internal
  @override
  $StreamProviderElement<List<DirectoryTeam>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<DirectoryTeam>> create(Ref ref) {
    return myTeams(ref);
  }
}

String _$myTeamsHash() => r'c64eb8d637593541854564f605c654822e366182';
