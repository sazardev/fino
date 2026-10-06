// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_team_command_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deleteTeamCommand)
final deleteTeamCommandProvider = DeleteTeamCommandProvider._();

final class DeleteTeamCommandProvider
    extends
        $FunctionalProvider<
          DeleteTeamCommand,
          DeleteTeamCommand,
          DeleteTeamCommand
        >
    with $Provider<DeleteTeamCommand> {
  DeleteTeamCommandProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteTeamCommandProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteTeamCommandHash();

  @$internal
  @override
  $ProviderElement<DeleteTeamCommand> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeleteTeamCommand create(Ref ref) {
    return deleteTeamCommand(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteTeamCommand value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteTeamCommand>(value),
    );
  }
}

String _$deleteTeamCommandHash() => r'e63f9903b2ada205dc5a46f50d391c2b2f99bfa8';
