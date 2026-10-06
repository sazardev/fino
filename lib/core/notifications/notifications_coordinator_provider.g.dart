// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_coordinator_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationsCoordinator)
final notificationsCoordinatorProvider = NotificationsCoordinatorProvider._();

final class NotificationsCoordinatorProvider
    extends
        $FunctionalProvider<
          NotificationsCoordinator,
          NotificationsCoordinator,
          NotificationsCoordinator
        >
    with $Provider<NotificationsCoordinator> {
  NotificationsCoordinatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationsCoordinatorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationsCoordinatorHash();

  @$internal
  @override
  $ProviderElement<NotificationsCoordinator> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationsCoordinator create(Ref ref) {
    return notificationsCoordinator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationsCoordinator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationsCoordinator>(value),
    );
  }
}

String _$notificationsCoordinatorHash() =>
    r'b525993efdd647caaf817cf6790f65aaf5f30a78';
