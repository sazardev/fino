// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regenerate_invite_code_command_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(regenerateInviteCodeCommand)
final regenerateInviteCodeCommandProvider =
    RegenerateInviteCodeCommandProvider._();

final class RegenerateInviteCodeCommandProvider
    extends
        $FunctionalProvider<
          RegenerateInviteCodeCommand,
          RegenerateInviteCodeCommand,
          RegenerateInviteCodeCommand
        >
    with $Provider<RegenerateInviteCodeCommand> {
  RegenerateInviteCodeCommandProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'regenerateInviteCodeCommandProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$regenerateInviteCodeCommandHash();

  @$internal
  @override
  $ProviderElement<RegenerateInviteCodeCommand> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RegenerateInviteCodeCommand create(Ref ref) {
    return regenerateInviteCodeCommand(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RegenerateInviteCodeCommand value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RegenerateInviteCodeCommand>(value),
    );
  }
}

String _$regenerateInviteCodeCommandHash() =>
    r'895e39c20adf0f1b28dee109ee56d3bc60b8efc1';
