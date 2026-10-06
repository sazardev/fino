import 'dart:convert';
import 'dart:io';

import 'json_post.dart';

/// [JsonPost] over `dart:io`. Used where no FlutterFire plugin exists
/// (Linux), so it never runs on the web.
Future<Map<String, Object?>> ioJsonPost(
  Uri url,
  Map<String, Object?> body,
) async {
  final client = HttpClient();
  try {
    final request = await client.postUrl(url);
    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(body));
    final response = await request.close();
    final text = await utf8.decodeStream(response);
    if (response.statusCode >= 400) {
      throw HttpException('HTTP ${response.statusCode}: $text', uri: url);
    }
    return jsonDecode(text) as Map<String, Object?>;
  } finally {
    client.close();
  }
}
