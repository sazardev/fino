// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_app_check_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(firebaseAppCheck)
final firebaseAppCheckProvider = FirebaseAppCheckProvider._();

final class FirebaseAppCheckProvider
    extends
        $FunctionalProvider<
          FirebaseAppCheck,
          FirebaseAppCheck,
          FirebaseAppCheck
        >
    with $Provider<FirebaseAppCheck> {
  FirebaseAppCheckProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firebaseAppCheckProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firebaseAppCheckHash();

  @$internal
  @override
  $ProviderElement<FirebaseAppCheck> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FirebaseAppCheck create(Ref ref) {
    return firebaseAppCheck(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirebaseAppCheck value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirebaseAppCheck>(value),
    );
  }
}

String _$firebaseAppCheckHash() => r'9600fb5f8901474de399aeb73a398073ea268c44';
