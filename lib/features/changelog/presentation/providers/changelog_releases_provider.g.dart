// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'changelog_releases_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The release history, newest first.

@ProviderFor(changelogReleases)
final changelogReleasesProvider = ChangelogReleasesProvider._();

/// The release history, newest first.

final class ChangelogReleasesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ChangelogRelease>>,
          List<ChangelogRelease>,
          FutureOr<List<ChangelogRelease>>
        >
    with
        $FutureModifier<List<ChangelogRelease>>,
        $FutureProvider<List<ChangelogRelease>> {
  /// The release history, newest first.
  ChangelogReleasesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'changelogReleasesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$changelogReleasesHash();

  @$internal
  @override
  $FutureProviderElement<List<ChangelogRelease>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ChangelogRelease>> create(Ref ref) {
    return changelogReleases(ref);
  }
}

String _$changelogReleasesHash() => r'021298dae1e718f45cf1b05e9f4530dafebaab57';
