// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_people_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Los miembros de un equipo, por nombre.

@ProviderFor(teamPeople)
final teamPeopleProvider = TeamPeopleFamily._();

/// Los miembros de un equipo, por nombre.

final class TeamPeopleProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DirectoryPerson>>,
          List<DirectoryPerson>,
          FutureOr<List<DirectoryPerson>>
        >
    with
        $FutureModifier<List<DirectoryPerson>>,
        $FutureProvider<List<DirectoryPerson>> {
  /// Los miembros de un equipo, por nombre.
  TeamPeopleProvider._({
    required TeamPeopleFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'teamPeopleProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$teamPeopleHash();

  @override
  String toString() {
    return r'teamPeopleProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<DirectoryPerson>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<DirectoryPerson>> create(Ref ref) {
    final argument = this.argument as String;
    return teamPeople(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TeamPeopleProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$teamPeopleHash() => r'7d83edd5106241d13785cf35147a1581ea48077d';

/// Los miembros de un equipo, por nombre.

final class TeamPeopleFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<DirectoryPerson>>, String> {
  TeamPeopleFamily._()
    : super(
        retry: null,
        name: r'teamPeopleProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Los miembros de un equipo, por nombre.

  TeamPeopleProvider call(String teamId) =>
      TeamPeopleProvider._(argument: teamId, from: this);

  @override
  String toString() => r'teamPeopleProvider';
}
