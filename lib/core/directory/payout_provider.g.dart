// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payout_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// El método de cobro de alguien, si se puede ver (SPEC M4).

@ProviderFor(payout)
final payoutProvider = PayoutFamily._();

/// El método de cobro de alguien, si se puede ver (SPEC M4).

final class PayoutProvider
    extends
        $FunctionalProvider<
          AsyncValue<DirectoryPayout?>,
          DirectoryPayout?,
          Stream<DirectoryPayout?>
        >
    with $FutureModifier<DirectoryPayout?>, $StreamProvider<DirectoryPayout?> {
  /// El método de cobro de alguien, si se puede ver (SPEC M4).
  PayoutProvider._({
    required PayoutFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'payoutProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$payoutHash();

  @override
  String toString() {
    return r'payoutProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<DirectoryPayout?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<DirectoryPayout?> create(Ref ref) {
    final argument = this.argument as (String, String);
    return payout(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is PayoutProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$payoutHash() => r'3d3cca8681aff98330c641455f92ad28b9545ac8';

/// El método de cobro de alguien, si se puede ver (SPEC M4).

final class PayoutFamily extends $Family
    with $FunctionalFamilyOverride<Stream<DirectoryPayout?>, (String, String)> {
  PayoutFamily._()
    : super(
        retry: null,
        name: r'payoutProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// El método de cobro de alguien, si se puede ver (SPEC M4).

  PayoutProvider call(String teamId, String userId) =>
      PayoutProvider._(argument: (teamId, userId), from: this);

  @override
  String toString() => r'payoutProvider';
}
