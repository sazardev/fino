// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_notifications_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localNotificationsService)
final localNotificationsServiceProvider = LocalNotificationsServiceProvider._();

final class LocalNotificationsServiceProvider
    extends
        $FunctionalProvider<
          LocalNotificationsService,
          LocalNotificationsService,
          LocalNotificationsService
        >
    with $Provider<LocalNotificationsService> {
  LocalNotificationsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localNotificationsServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localNotificationsServiceHash();

  @$internal
  @override
  $ProviderElement<LocalNotificationsService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalNotificationsService create(Ref ref) {
    return localNotificationsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalNotificationsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalNotificationsService>(value),
    );
  }
}

String _$localNotificationsServiceHash() =>
    r'a5d0f40ff9884d88a5cc6979a2ba456327b780dc';
