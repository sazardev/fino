// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inbox_navigator_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Lo sobrescribe la app con su router (`appProviderOverrides`).

@ProviderFor(inboxNavigator)
final inboxNavigatorProvider = InboxNavigatorProvider._();

/// Lo sobrescribe la app con su router (`appProviderOverrides`).

final class InboxNavigatorProvider
    extends $FunctionalProvider<InboxNavigator, InboxNavigator, InboxNavigator>
    with $Provider<InboxNavigator> {
  /// Lo sobrescribe la app con su router (`appProviderOverrides`).
  InboxNavigatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inboxNavigatorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inboxNavigatorHash();

  @$internal
  @override
  $ProviderElement<InboxNavigator> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  InboxNavigator create(Ref ref) {
    return inboxNavigator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InboxNavigator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InboxNavigator>(value),
    );
  }
}

String _$inboxNavigatorHash() => r'f08c0e8a4ad690a8c2e48fcf4c03fa0156717caf';
