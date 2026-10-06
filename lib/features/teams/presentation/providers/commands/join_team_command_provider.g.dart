// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_team_command_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(joinTeamCommand)
final joinTeamCommandProvider = JoinTeamCommandProvider._();

final class JoinTeamCommandProvider
    extends
        $FunctionalProvider<JoinTeamCommand, JoinTeamCommand, JoinTeamCommand>
    with $Provider<JoinTeamCommand> {
  JoinTeamCommandProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'joinTeamCommandProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$joinTeamCommandHash();

  @$internal
  @override
  $ProviderElement<JoinTeamCommand> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  JoinTeamCommand create(Ref ref) {
    return joinTeamCommand(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(JoinTeamCommand value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<JoinTeamCommand>(value),
    );
  }
}

String _$joinTeamCommandHash() => r'04339803012a316c9093a48137a12c0cf856d98a';
