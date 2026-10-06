// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_member_profile_command_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(refreshMemberProfileCommand)
final refreshMemberProfileCommandProvider =
    RefreshMemberProfileCommandProvider._();

final class RefreshMemberProfileCommandProvider
    extends
        $FunctionalProvider<
          RefreshMemberProfileCommand,
          RefreshMemberProfileCommand,
          RefreshMemberProfileCommand
        >
    with $Provider<RefreshMemberProfileCommand> {
  RefreshMemberProfileCommandProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'refreshMemberProfileCommandProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$refreshMemberProfileCommandHash();

  @$internal
  @override
  $ProviderElement<RefreshMemberProfileCommand> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RefreshMemberProfileCommand create(Ref ref) {
    return refreshMemberProfileCommand(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RefreshMemberProfileCommand value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RefreshMemberProfileCommand>(value),
    );
  }
}

String _$refreshMemberProfileCommandHash() =>
    r'29e57a1c38ef0423b9a3460d9c832ce4accb09eb';
