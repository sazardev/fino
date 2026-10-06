import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../design/app_spacing.dart';
import '../molecules/floating_back_button.dart';
import '../molecules/screen_title.dart';
import '../responsive/responsive.dart';

/// Como `SettingsShell`, pero para listas largas: los elementos se construyen
/// a demanda (`SliverList.builder`), así una lista de cientos no pesa.
///
/// [header] va arriba (búsqueda, filtros, resúmenes); si no hay elementos se
/// muestra [empty]. Deja aire abajo para el FAB.
class ListShell extends StatelessWidget {
  const new({
    required this.itemCount,
    required this.itemBuilder,
    super.key,
    this.header = const [],
    this.footer = const [],
    this.empty,
    this.title,
    this.onBack,
    this.loaded = true,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final List<Widget> header;
  final List<Widget> footer;
  final Widget? empty;
  final String? title;
  final VoidCallback? onBack;
  final bool loaded;

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final backSize = 44 * r.scale;
    final onBack = this.onBack;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, box) {
            final side = math.max(
              r.pagePadding,
              (box.maxWidth - r.contentWidth) / 2,
            );
            Widget padded(Widget sliver) => SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: side),
              sliver: sliver,
            );

            return Stack(
              children: [
                if (!loaded)
                  const Center(child: CircularProgressIndicator())
                else
                  CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: onBack != null
                              ? backSize + AppSpacing.md
                              : AppSpacing.sm,
                        ),
                      ),
                      padded(
                        SliverList.list(
                          children: [
                            if (title != null) ScreenTitle(title!),
                            ...header,
                          ],
                        ),
                      ),
                      if (itemCount == 0 && empty != null)
                        padded(SliverToBoxAdapter(child: empty))
                      else
                        padded(
                          SliverList.builder(
                            itemCount: itemCount,
                            itemBuilder: itemBuilder,
                          ),
                        ),
                      padded(SliverList.list(children: footer)),
                      const SliverToBoxAdapter(child: SizedBox(height: 96)),
                    ],
                  ),
                if (onBack != null)
                  Positioned(
                    left: math.max(r.pagePadding / 2, side - r.pagePadding / 2),
                    top: AppSpacing.sm,
                    child: FloatingBackButton(onPressed: onBack),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
