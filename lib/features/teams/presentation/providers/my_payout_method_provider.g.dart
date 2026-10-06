// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_payout_method_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Mi cuenta de cobro en el equipo (SPEC M1).

@ProviderFor(myPayoutMethod)
final myPayoutMethodProvider = MyPayoutMethodFamily._();

/// Mi cuenta de cobro en el equipo (SPEC M1).

final class MyPayoutMethodProvider
    extends
        $FunctionalProvider<
          AsyncValue<PayoutMethod?>,
          PayoutMethod?,
          Stream<PayoutMethod?>
        >
    with $FutureModifier<PayoutMethod?>, $StreamProvider<PayoutMethod?> {
  /// Mi cuenta de cobro en el equipo (SPEC M1).
  MyPayoutMethodProvider._({
    required MyPayoutMethodFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'myPayoutMethodProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$myPayoutMethodHash();

  @override
  String toString() {
    return r'myPayoutMethodProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<PayoutMethod?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<PayoutMethod?> create(Ref ref) {
    final argument = this.argument as String;
    return myPayoutMethod(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MyPayoutMethodProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$myPayoutMethodHash() => r'fa588a8a5c31200f8eb2c4ae2028afae01e84c51';

/// Mi cuenta de cobro en el equipo (SPEC M1).

final class MyPayoutMethodFamily extends $Family
    with $FunctionalFamilyOverride<Stream<PayoutMethod?>, String> {
  MyPayoutMethodFamily._()
    : super(
        retry: null,
        name: r'myPayoutMethodProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Mi cuenta de cobro en el equipo (SPEC M1).

  MyPayoutMethodProvider call(String teamId) =>
      MyPayoutMethodProvider._(argument: teamId, from: this);

  @override
  String toString() => r'myPayoutMethodProvider';
}
