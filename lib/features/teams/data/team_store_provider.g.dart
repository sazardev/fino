// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_store_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(teamStore)
final teamStoreProvider = TeamStoreProvider._();

final class TeamStoreProvider
    extends $FunctionalProvider<TeamStore, TeamStore, TeamStore>
    with $Provider<TeamStore> {
  TeamStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'teamStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$teamStoreHash();

  @$internal
  @override
  $ProviderElement<TeamStore> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TeamStore create(Ref ref) {
    return teamStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TeamStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TeamStore>(value),
    );
  }
}

String _$teamStoreHash() => r'df65eaf8519f95d717ecebe4edc821c2bc6b6d53';

@ProviderFor(liveDebtsDirectory)
final liveDebtsDirectoryProvider = LiveDebtsDirectoryProvider._();

final class LiveDebtsDirectoryProvider
    extends
        $FunctionalProvider<
          LiveDebtsDirectory,
          LiveDebtsDirectory,
          LiveDebtsDirectory
        >
    with $Provider<LiveDebtsDirectory> {
  LiveDebtsDirectoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveDebtsDirectoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveDebtsDirectoryHash();

  @$internal
  @override
  $ProviderElement<LiveDebtsDirectory> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LiveDebtsDirectory create(Ref ref) {
    return liveDebtsDirectory(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LiveDebtsDirectory value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LiveDebtsDirectory>(value),
    );
  }
}

String _$liveDebtsDirectoryHash() =>
    r'c76ac848aeb40fabc330e7aeca554b2662ec9149';

@ProviderFor(inviteLookup)
final inviteLookupProvider = InviteLookupProvider._();

final class InviteLookupProvider
    extends $FunctionalProvider<InviteLookup, InviteLookup, InviteLookup>
    with $Provider<InviteLookup> {
  InviteLookupProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inviteLookupProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inviteLookupHash();

  @$internal
  @override
  $ProviderElement<InviteLookup> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  InviteLookup create(Ref ref) {
    return inviteLookup(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InviteLookup value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InviteLookup>(value),
    );
  }
}

String _$inviteLookupHash() => r'4786e9316a73571df0ddebc793126b768a8c556e';
