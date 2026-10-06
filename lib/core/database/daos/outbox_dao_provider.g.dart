// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outbox_dao_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(outboxDao)
final outboxDaoProvider = OutboxDaoProvider._();

final class OutboxDaoProvider
    extends $FunctionalProvider<OutboxDao, OutboxDao, OutboxDao>
    with $Provider<OutboxDao> {
  OutboxDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'outboxDaoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$outboxDaoHash();

  @$internal
  @override
  $ProviderElement<OutboxDao> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  OutboxDao create(Ref ref) {
    return outboxDao(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OutboxDao value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OutboxDao>(value),
    );
  }
}

String _$outboxDaoHash() => r'7f21b78bfe0114b2c3520326d507436fe33eb284';
