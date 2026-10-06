import 'package:flutter/material.dart';

import '../../ui/templates/settings_shell.dart';
import 'sections/buttons_section.dart';
import 'sections/feedback_section.dart';
import 'sections/selection_section.dart';
import 'sections/typography_section.dart';

/// Every component of the design system on one screen, for eyeballing.
class GalleryPage extends StatelessWidget {
  const new({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return SettingsShell(
      onBack: onBack,
      children: const [
        ButtonsSection(),
        SelectionSection(),
        FeedbackSection(),
        TypographySection(),
      ],
    );
  }
}
