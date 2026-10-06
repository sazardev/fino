/// What a pending outbox entry asks the server to do.
enum OutboxOperation {
  /// Strict create: fails if the document already exists.
  create,

  /// Partial update of an existing document.
  update,

  /// Create-or-replace (idempotent, safe to retry).
  set,
  delete,
}
