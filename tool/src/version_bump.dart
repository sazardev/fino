/// Which part of `major.minor.patch` a release moves.
enum BumpPart { major, minor, patch }

/// The result of bumping a pubspec: the old and new `x.y.z+build`, and the
/// pubspec text with the new version in place.
typedef VersionBump = ({String from, String to, String pubspec});

final _versionLine = RegExp(
  r'^version:[ \t]*(\d+)\.(\d+)\.(\d+)\+(\d+)[ \t]*$',
  multiLine: true,
);

/// Bumps `version: x.y.z+build` in [pubspec]: [part] moves the semver
/// (lower parts reset to 0) and the build number always goes up by one.
///
/// Throws [FormatException] when there is no such line.
VersionBump bumpPubspecVersion(String pubspec, BumpPart part) {
  final match = _versionLine.firstMatch(pubspec);
  if (match == null) {
    throw const FormatException('No `version: X.Y.Z+B` line in pubspec.yaml.');
  }
  final [major, minor, patch, build] = [
    for (var i = 1; i <= 4; i++) int.parse(match.group(i)!),
  ];
  final next = switch (part) {
    BumpPart.major => '${major + 1}.0.0',
    BumpPart.minor => '$major.${minor + 1}.0',
    BumpPart.patch => '$major.$minor.${patch + 1}',
  };
  final to = '$next+${build + 1}';
  return (
    from: '$major.$minor.$patch+$build',
    to: to,
    pubspec: pubspec.replaceFirst(match.group(0)!, 'version: $to'),
  );
}
