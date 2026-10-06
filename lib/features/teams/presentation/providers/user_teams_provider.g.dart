// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_teams_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The teams [userId] belongs to, by name.

@ProviderFor(userTeams)
final userTeamsProvider = UserTeamsFamily._();

/// The teams [userId] belongs to, by name.

final class UserTeamsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TeamSummary>>,
          List<TeamSummary>,
          Stream<List<TeamSummary>>
        >
    with
        $FutureModifier<List<TeamSummary>>,
        $StreamProvider<List<TeamSummary>> {
  /// The teams [userId] belongs to, by name.
  UserTeamsProvider._({
    required UserTeamsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'userTeamsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userTeamsHash();

  @override
  String toString() {
    return r'userTeamsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<TeamSummary>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<TeamSummary>> create(Ref ref) {
    final argument = this.argument as String;
    return userTeams(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UserTeamsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userTeamsHash() => r'cb4d40b3037a9c234c2711caed6e451dadee490a';

/// The teams [userId] belongs to, by name.

final class UserTeamsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<TeamSummary>>, String> {
  UserTeamsFamily._()
    : super(
        retry: null,
        name: r'userTeamsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The teams [userId] belongs to, by name.

  UserTeamsProvider call(String userId) =>
      UserTeamsProvider._(argument: userId, from: this);

  @override
  String toString() => r'userTeamsProvider';
}
