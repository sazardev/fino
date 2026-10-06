// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ordersRepository)
final ordersRepositoryProvider = OrdersRepositoryProvider._();

final class OrdersRepositoryProvider
    extends
        $FunctionalProvider<
          OrdersRepository,
          OrdersRepository,
          OrdersRepository
        >
    with $Provider<OrdersRepository> {
  OrdersRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ordersRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ordersRepositoryHash();

  @$internal
  @override
  $ProviderElement<OrdersRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  OrdersRepository create(Ref ref) {
    return ordersRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OrdersRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OrdersRepository>(value),
    );
  }
}

String _$ordersRepositoryHash() => r'02c5e118406a3f5272cd5ca8d1d1e54aa5aa5850';

@ProviderFor(teamDirectory)
final teamDirectoryProvider = TeamDirectoryProvider._();

final class TeamDirectoryProvider
    extends $FunctionalProvider<TeamDirectory, TeamDirectory, TeamDirectory>
    with $Provider<TeamDirectory> {
  TeamDirectoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'teamDirectoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$teamDirectoryHash();

  @$internal
  @override
  $ProviderElement<TeamDirectory> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TeamDirectory create(Ref ref) {
    return teamDirectory(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TeamDirectory value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TeamDirectory>(value),
    );
  }
}

String _$teamDirectoryHash() => r'4d2034735c7266f18f73d96b3be05c0f1f0ca326';
