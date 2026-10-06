// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_team_command_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(createTeamCommand)
final createTeamCommandProvider = CreateTeamCommandProvider._();

final class CreateTeamCommandProvider
    extends
        $FunctionalProvider<
          CreateTeamCommand,
          CreateTeamCommand,
          CreateTeamCommand
        >
    with $Provider<CreateTeamCommand> {
  CreateTeamCommandProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createTeamCommandProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createTeamCommandHash();

  @$internal
  @override
  $ProviderElement<CreateTeamCommand> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CreateTeamCommand create(Ref ref) {
    return createTeamCommand(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateTeamCommand value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateTeamCommand>(value),
    );
  }
}

String _$createTeamCommandHash() => r'dd82c9be91d714d2f2942fef9d1e7e85166d5262';
