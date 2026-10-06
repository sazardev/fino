import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// DESIGN.md §0 and §1 as executable rules: these never appear in `lib/`.
void main() {
  final forbidden = {
    RegExp(r'\bAppBar\s*\('): 'AppBar: no top bars (DESIGN.md §0.1)',
    RegExp(r'\bSliverAppBar\b'): 'SliverAppBar: no top bars (DESIGN.md §0.1)',
    RegExp(r'\bappBar\s*:'): 'Scaffold.appBar: no top bars (DESIGN.md §0.1)',
    RegExp(r'\bAlertDialog\b'): 'dialogs: confirm in place (DESIGN.md §1.5)',
    RegExp(r'\bshowDialog\b'): 'dialogs: confirm in place (DESIGN.md §1.5)',
    RegExp(r'\bshowModalBottomSheet\b'): 'sheets: no modals (DESIGN.md §1.5)',
    RegExp(r'\bshowBottomSheet\b'): 'sheets: no modals (DESIGN.md §1.5)',
    RegExp(r'\bInkWell\b'): 'InkWell: use BouncyTap, no ripple (DESIGN.md §3)',
    RegExp(r'\bBoxShadow\b'): 'shadows: the design is flat (DESIGN.md §1.1)',
    RegExp(r'\bHapticFeedback\.'): 'raw haptics: use Haptics.* (DESIGN.md §7)',
  };

  final files = Directory('lib')
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'));

  test('lib/ follows the design rules', () {
    final violations = <String>[];
    for (final file in files) {
      // The one place allowed to call the platform haptics.
      if (file.path.endsWith('system_haptic_engine.dart')) continue;
      final lines = file.readAsLinesSync();
      for (var i = 0; i < lines.length; i++) {
        final code = lines[i].split('//').first;
        for (final MapEntry(key: pattern, value: why) in forbidden.entries) {
          if (pattern.hasMatch(code)) {
            violations.add('${file.path}:${i + 1}  $why');
          }
        }
      }
    }
    expect(violations, isEmpty, reason: violations.join('\n'));
  });

  // Known debt: the calligraphic logo painter. Split PenStroke out of it once
  // its design settles, then empty this set.
  const oversize = {'lib/ui/brand/fino_mark_painter.dart'};

  test('no file grows past 150 lines (one thing per file)', () {
    final tooBig = {
      for (final f in files)
        if (f.readAsLinesSync().length > 150) f.path,
    };
    expect(
      tooBig.difference(oversize),
      isEmpty,
      reason: 'split these: ${tooBig.difference(oversize)}',
    );
  });
}
