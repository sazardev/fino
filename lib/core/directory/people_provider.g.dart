// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Todas las personas de mis equipos, por clave `equipo/usuario`.

@ProviderFor(people)
final peopleProvider = PeopleProvider._();

/// Todas las personas de mis equipos, por clave `equipo/usuario`.

final class PeopleProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, DirectoryPerson>>,
          Map<String, DirectoryPerson>,
          Stream<Map<String, DirectoryPerson>>
        >
    with
        $FutureModifier<Map<String, DirectoryPerson>>,
        $StreamProvider<Map<String, DirectoryPerson>> {
  /// Todas las personas de mis equipos, por clave `equipo/usuario`.
  PeopleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'peopleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$peopleHash();

  @$internal
  @override
  $StreamProviderElement<Map<String, DirectoryPerson>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<Map<String, DirectoryPerson>> create(Ref ref) {
    return people(ref);
  }
}

String _$peopleHash() => r'110a5be33defef64df7f6543ff24f3cd77d889c4';
