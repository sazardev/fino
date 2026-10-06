/// What a user-facing change is: a `feat`, a `fix` or a `perf` commit.
/// Every other commit type is release noise and never reaches the app.
enum ChangelogNoteType { feature, fix, improvement }
