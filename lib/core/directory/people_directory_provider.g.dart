// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_directory_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(peopleDirectory)
final peopleDirectoryProvider = PeopleDirectoryProvider._();

final class PeopleDirectoryProvider
    extends
        $FunctionalProvider<PeopleDirectory, PeopleDirectory, PeopleDirectory>
    with $Provider<PeopleDirectory> {
  PeopleDirectoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'peopleDirectoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$peopleDirectoryHash();

  @$internal
  @override
  $ProviderElement<PeopleDirectory> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PeopleDirectory create(Ref ref) {
    return peopleDirectory(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PeopleDirectory value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PeopleDirectory>(value),
    );
  }
}

String _$peopleDirectoryHash() => r'093336811e06041bd2c8c39dcf921453461d5a6f';
