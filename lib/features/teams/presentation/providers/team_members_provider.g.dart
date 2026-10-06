// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_members_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Los miembros de un equipo, el más antiguo primero.

@ProviderFor(teamMembers)
final teamMembersProvider = TeamMembersFamily._();

/// Los miembros de un equipo, el más antiguo primero.

final class TeamMembersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TeamMember>>,
          List<TeamMember>,
          Stream<List<TeamMember>>
        >
    with $FutureModifier<List<TeamMember>>, $StreamProvider<List<TeamMember>> {
  /// Los miembros de un equipo, el más antiguo primero.
  TeamMembersProvider._({
    required TeamMembersFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'teamMembersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$teamMembersHash();

  @override
  String toString() {
    return r'teamMembersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<TeamMember>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<TeamMember>> create(Ref ref) {
    final argument = this.argument as String;
    return teamMembers(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TeamMembersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$teamMembersHash() => r'430a9e46db69b1dd843f88e81ee0086d84c7c1eb';

/// Los miembros de un equipo, el más antiguo primero.

final class TeamMembersFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<TeamMember>>, String> {
  TeamMembersFamily._()
    : super(
        retry: null,
        name: r'teamMembersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Los miembros de un equipo, el más antiguo primero.

  TeamMembersProvider call(String teamId) =>
      TeamMembersProvider._(argument: teamId, from: this);

  @override
  String toString() => r'teamMembersProvider';
}
