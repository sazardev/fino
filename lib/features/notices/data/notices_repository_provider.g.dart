// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notices_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(noticesRepository)
final noticesRepositoryProvider = NoticesRepositoryProvider._();

final class NoticesRepositoryProvider
    extends
        $FunctionalProvider<
          NoticesRepository,
          NoticesRepository,
          NoticesRepository
        >
    with $Provider<NoticesRepository> {
  NoticesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'noticesRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$noticesRepositoryHash();

  @$internal
  @override
  $ProviderElement<NoticesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NoticesRepository create(Ref ref) {
    return noticesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NoticesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NoticesRepository>(value),
    );
  }
}

String _$noticesRepositoryHash() => r'f68299a1e506c9d61d8dfd2eea02119527127e98';

@ProviderFor(noticeAudience)
final noticeAudienceProvider = NoticeAudienceProvider._();

final class NoticeAudienceProvider
    extends $FunctionalProvider<NoticeAudience, NoticeAudience, NoticeAudience>
    with $Provider<NoticeAudience> {
  NoticeAudienceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'noticeAudienceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$noticeAudienceHash();

  @$internal
  @override
  $ProviderElement<NoticeAudience> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NoticeAudience create(Ref ref) {
    return noticeAudience(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NoticeAudience value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NoticeAudience>(value),
    );
  }
}

String _$noticeAudienceHash() => r'2f09962828f31ed8243a4fe8e0ae6fa9389e8e10';
