// Renders the finished Fino "F" (the splash's `FinoMarkPainter` at progress 1)
// as a white-on-transparent PNG. `tool/gen_icons.sh` runs this and derives
// every launcher icon from the result, so the icon is always the splash logo.
//
// Usage: OUT=build/icons/mark.png flutter test tool/icons/render_mark.dart
import 'dart:io';
import 'dart:ui' as ui;

import 'package:fino/ui/brand/fino_mark_painter.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_test/flutter_test.dart';

const _side = 2048;

void main() {
  test('renders the finished mark', () async {
    final out = Platform.environment['OUT'] ?? 'build/icons/mark.png';
    final recorder = ui.PictureRecorder();
    FinoMarkPainter(
      progress: const AlwaysStoppedAnimation(1),
      color: const Color(0xFFFFFFFF),
    ).paint(ui.Canvas(recorder), Size.square(_side.toDouble()));
    final image = await recorder.endRecording().toImage(_side, _side);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);

    File(out)
      ..createSync(recursive: true)
      ..writeAsBytesSync(bytes!.buffer.asUint8List());
  });
}
