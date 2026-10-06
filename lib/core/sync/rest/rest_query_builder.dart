import '../remote_filter.dart';
import '../remote_filter_op.dart';
import 'rest_value_codec.dart';

/// Arma el `structuredQuery` de `:runQuery`.
abstract final class RestQueryBuilder {
  static Map<String, Object?> query({
    required String collectionId,
    required bool allDescendants,
    required List<RemoteFilter> where,
  }) => {
    'structuredQuery': {
      'from': [
        {'collectionId': collectionId, 'allDescendants': allDescendants},
      ],
      if (where.isNotEmpty) 'where': _where(where),
    },
  };

  static Map<String, Object?> _where(List<RemoteFilter> filters) {
    final encoded = [
      for (final f in filters) {'fieldFilter': _field(f)},
    ];
    return encoded.length == 1
        ? encoded.single
        : {
            'compositeFilter': {'op': 'AND', 'filters': encoded},
          };
  }

  static Map<String, Object?> _field(RemoteFilter filter) => {
    'field': {'fieldPath': filter.field},
    'op': switch (filter.op) {
      RemoteFilterOp.equal => 'EQUAL',
      RemoteFilterOp.arrayContains => 'ARRAY_CONTAINS',
    },
    'value': RestValueCodec.encode(filter.value),
  };
}
