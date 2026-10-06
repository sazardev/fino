import 'package:flutter/material.dart';

/// La cara de alguien: su foto de Google o, si no tiene, sus iniciales sobre
/// un color que siempre es el mismo para esa persona (SPEC U3).
class PersonAvatar extends StatelessWidget {
  const new({
    required this.name,
    required this.seed,
    super.key,
    this.photoUrl,
    this.size = 40,
  });

  final String name;

  /// Lo que fija el color (el id del usuario).
  final String seed;
  final String? photoUrl;
  final double size;

  static String initialsOf(String name) {
    final words = name.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty);
    if (words.isEmpty) return '?';
    final letters = words.take(2).map((w) => w.characters.first.toUpperCase());
    return letters.join();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final hue = (seed.codeUnits.fold(0, (a, c) => a * 31 + c) % 360).toDouble();
    final background = HSLColor.fromAHSL(1, hue, 0.45, 0.62).toColor();
    final photo = photoUrl;
    final pixels = (size * MediaQuery.devicePixelRatioOf(context)).round();

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: background, shape: BoxShape.circle),
      child: photo == null
          ? Text(
              initialsOf(name),
              style: TextStyle(
                color: scheme.surface,
                fontWeight: FontWeight.w700,
                fontSize: size * 0.38,
              ),
            )
          : Image.network(
              photo,
              width: size,
              height: size,
              fit: BoxFit.cover,
              cacheWidth: pixels,
              cacheHeight: pixels,
              errorBuilder: (_, _, _) => Text(initialsOf(name)),
            ),
    );
  }
}
