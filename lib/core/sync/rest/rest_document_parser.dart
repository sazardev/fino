import '../remote_document.dart';
import 'rest_value_codec.dart';

/// Un documento de la API REST (`{"name": …, "fields": …}`) → [RemoteDocument].
abstract final class RestDocumentParser {
  static RemoteDocument parse(Map<String, Object?> json) {
    final name = json['name']! as String;
    const marker = '/documents/';
    return RemoteDocument(
      name.substring(name.indexOf(marker) + marker.length),
      RestValueCodec.decodeFields(
        (json['fields'] as Map<String, Object?>?) ?? const {},
      ),
    );
  }
}
