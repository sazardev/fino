import 'package:fino/core/sync/remote_marker.dart';

/// Lo que el servidor devolvería: `serverTimestamp` → [at]; los campos
/// borrados desaparecen.
Map<String, Object?> resolveMarkers(Map<String, Object?> fields, DateTime at) =>
    {
      for (final MapEntry(:key, :value) in fields.entries)
        if (value != RemoteMarker.fieldDelete)
          key: value == RemoteMarker.serverTimestamp ? at : value,
    };
