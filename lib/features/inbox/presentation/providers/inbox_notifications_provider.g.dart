// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inbox_notifications_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Mi buzón, lo más reciente primero (SPEC N2).

@ProviderFor(inboxNotifications)
final inboxNotificationsProvider = InboxNotificationsProvider._();

/// Mi buzón, lo más reciente primero (SPEC N2).

final class InboxNotificationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<InboxNotification>>,
          List<InboxNotification>,
          Stream<List<InboxNotification>>
        >
    with
        $FutureModifier<List<InboxNotification>>,
        $StreamProvider<List<InboxNotification>> {
  /// Mi buzón, lo más reciente primero (SPEC N2).
  InboxNotificationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inboxNotificationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inboxNotificationsHash();

  @$internal
  @override
  $StreamProviderElement<List<InboxNotification>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<InboxNotification>> create(Ref ref) {
    return inboxNotifications(ref);
  }
}

String _$inboxNotificationsHash() =>
    r'b73eafc3abbf309a9a51b9d04e9185c508466a88';
