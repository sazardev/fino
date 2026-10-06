import 'dart:convert';
import 'dart:io';

import 'package:fino/core/http/io_json_post.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late HttpServer server;
  late Uri url;
  late String lastBody;

  Future<void> serve(int status, String body) async {
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    url = Uri.http('localhost:${server.port}', '/x');
    server.listen((request) async {
      lastBody = await utf8.decodeStream(request);
      request.response
        ..statusCode = status
        ..write(body);
      await request.response.close();
    });
  }

  tearDown(() => server.close(force: true));

  test('sends JSON and decodes the JSON answer', () async {
    await serve(200, '{"ok":true}');

    final response = await ioJsonPost(url, {'a': 1});

    expect(jsonDecode(lastBody), {'a': 1});
    expect(response, {'ok': true});
  });

  test('an error status becomes an exception carrying the body', () async {
    await serve(400, 'nope');

    await expectLater(
      ioJsonPost(url, {}),
      throwsA(
        isA<HttpException>().having(
          (e) => e.message,
          'message',
          contains('nope'),
        ),
      ),
    );
  });
}
