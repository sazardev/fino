/// POSTs [body] as JSON to [url] and returns the decoded JSON response.
/// Throws when the server answers with an error status.
typedef JsonPost = Future<Map<String, Object?>> Function(
  Uri url,
  Map<String, Object?> body,
);
