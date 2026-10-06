// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owed_to_me_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Quién me debe algo vivo en el equipo y cuánto (SPEC A1, A4).

@ProviderFor(owedToMe)
final owedToMeProvider = OwedToMeFamily._();

/// Quién me debe algo vivo en el equipo y cuánto (SPEC A1, A4).

final class OwedToMeProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, Money>>,
          Map<String, Money>,
          FutureOr<Map<String, Money>>
        >
    with
        $FutureModifier<Map<String, Money>>,
        $FutureProvider<Map<String, Money>> {
  /// Quién me debe algo vivo en el equipo y cuánto (SPEC A1, A4).
  OwedToMeProvider._({
    required OwedToMeFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'owedToMeProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$owedToMeHash();

  @override
  String toString() {
    return r'owedToMeProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Map<String, Money>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, Money>> create(Ref ref) {
    final argument = this.argument as String;
    return owedToMe(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is OwedToMeProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$owedToMeHash() => r'a656addcd88770773cebc0a8656533a29c06af69';

/// Quién me debe algo vivo en el equipo y cuánto (SPEC A1, A4).

final class OwedToMeFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Map<String, Money>>, String> {
  OwedToMeFamily._()
    : super(
        retry: null,
        name: r'owedToMeProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Quién me debe algo vivo en el equipo y cuánto (SPEC A1, A4).

  OwedToMeProvider call(String teamId) =>
      OwedToMeProvider._(argument: teamId, from: this);

  @override
  String toString() => r'owedToMeProvider';
}
