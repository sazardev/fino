// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'changelog_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Where the release history comes from; tests override it.

@ProviderFor(changelogRepository)
final changelogRepositoryProvider = ChangelogRepositoryProvider._();

/// Where the release history comes from; tests override it.

final class ChangelogRepositoryProvider
    extends
        $FunctionalProvider<
          ChangelogRepository,
          ChangelogRepository,
          ChangelogRepository
        >
    with $Provider<ChangelogRepository> {
  /// Where the release history comes from; tests override it.
  ChangelogRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'changelogRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$changelogRepositoryHash();

  @$internal
  @override
  $ProviderElement<ChangelogRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ChangelogRepository create(Ref ref) {
    return changelogRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChangelogRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChangelogRepository>(value),
    );
  }
}

String _$changelogRepositoryHash() =>
    r'bf021d02e660445f530206f94f5393aae0b77a6d';
