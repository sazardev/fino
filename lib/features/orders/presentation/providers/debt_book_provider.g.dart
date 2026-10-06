// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debt_book_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Debo / Me deben de quien está en sesión (SPEC §7.2).

@ProviderFor(debtBook)
final debtBookProvider = DebtBookProvider._();

/// Debo / Me deben de quien está en sesión (SPEC §7.2).

final class DebtBookProvider
    extends
        $FunctionalProvider<AsyncValue<DebtBook>, DebtBook, Stream<DebtBook>>
    with $FutureModifier<DebtBook>, $StreamProvider<DebtBook> {
  /// Debo / Me deben de quien está en sesión (SPEC §7.2).
  DebtBookProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debtBookProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debtBookHash();

  @$internal
  @override
  $StreamProviderElement<DebtBook> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<DebtBook> create(Ref ref) {
    return debtBook(ref);
  }
}

String _$debtBookHash() => r'31a493f1db7c9791cb986d00f2037239aca918af';
