// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debtor_candidates_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Quién más puede entrar al pedido: del equipo, que no sea yo ni tenga ya
/// una deuda activa en él (P6).

@ProviderFor(debtorCandidates)
final debtorCandidatesProvider = DebtorCandidatesFamily._();

/// Quién más puede entrar al pedido: del equipo, que no sea yo ni tenga ya
/// una deuda activa en él (P6).

final class DebtorCandidatesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DirectoryPerson>>,
          List<DirectoryPerson>,
          FutureOr<List<DirectoryPerson>>
        >
    with
        $FutureModifier<List<DirectoryPerson>>,
        $FutureProvider<List<DirectoryPerson>> {
  /// Quién más puede entrar al pedido: del equipo, que no sea yo ni tenga ya
  /// una deuda activa en él (P6).
  DebtorCandidatesProvider._({
    required DebtorCandidatesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'debtorCandidatesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$debtorCandidatesHash();

  @override
  String toString() {
    return r'debtorCandidatesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<DirectoryPerson>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<DirectoryPerson>> create(Ref ref) {
    final argument = this.argument as String;
    return debtorCandidates(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DebtorCandidatesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$debtorCandidatesHash() => r'f3b6c1dbf60fb8c5750c827967390ff184955b08';

/// Quién más puede entrar al pedido: del equipo, que no sea yo ni tenga ya
/// una deuda activa en él (P6).

final class DebtorCandidatesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<DirectoryPerson>>, String> {
  DebtorCandidatesFamily._()
    : super(
        retry: null,
        name: r'debtorCandidatesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Quién más puede entrar al pedido: del equipo, que no sea yo ni tenga ya
  /// una deuda activa en él (P6).

  DebtorCandidatesProvider call(String orderId) =>
      DebtorCandidatesProvider._(argument: orderId, from: this);

  @override
  String toString() => r'debtorCandidatesProvider';
}
