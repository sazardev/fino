// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_team_command_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(leaveTeamCommand)
final leaveTeamCommandProvider = LeaveTeamCommandProvider._();

final class LeaveTeamCommandProvider
    extends
        $FunctionalProvider<
          LeaveTeamCommand,
          LeaveTeamCommand,
          LeaveTeamCommand
        >
    with $Provider<LeaveTeamCommand> {
  LeaveTeamCommandProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'leaveTeamCommandProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$leaveTeamCommandHash();

  @$internal
  @override
  $ProviderElement<LeaveTeamCommand> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LeaveTeamCommand create(Ref ref) {
    return leaveTeamCommand(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LeaveTeamCommand value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LeaveTeamCommand>(value),
    );
  }
}

String _$leaveTeamCommandHash() => r'7f6c79c35eac7cf06e8845bb1e79c7f0d6993e25';
