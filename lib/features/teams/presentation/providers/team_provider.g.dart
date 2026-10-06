// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(team)
final teamProvider = TeamFamily._();

final class TeamProvider
    extends $FunctionalProvider<AsyncValue<Team?>, Team?, Stream<Team?>>
    with $FutureModifier<Team?>, $StreamProvider<Team?> {
  TeamProvider._({
    required TeamFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'teamProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$teamHash();

  @override
  String toString() {
    return r'teamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Team?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Team?> create(Ref ref) {
    final argument = this.argument as String;
    return team(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TeamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$teamHash() => r'33bf3703c0bc6778aec6e397f64e68fbaed04c9b';

final class TeamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Team?>, String> {
  TeamFamily._()
    : super(
        retry: null,
        name: r'teamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TeamProvider call(String teamId) =>
      TeamProvider._(argument: teamId, from: this);

  @override
  String toString() => r'teamProvider';
}
