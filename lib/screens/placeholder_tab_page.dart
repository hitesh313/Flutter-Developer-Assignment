import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Shown for any top-level tab other than Smart Post, since the Figma
/// file only designs that one. Reachable by tapping the tab or swiping
/// horizontally — makes it clear which section you landed on rather
/// than showing a blank screen.
class PlaceholderTabPage extends StatelessWidget {
  final String name;
  const PlaceholderTabPage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    final palette = paletteOf(context);
    return Container(
      color: palette.scaffoldBg,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.widgets_outlined, size: 40, color: palette.textSecondary),
          const SizedBox(height: AppSpacing.md),
          Text(
            "You're on the $name page",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: palette.textPrimary),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            "This section isn't part of the Smart Post design yet \u2014 swipe right or tap Smart Post to head back.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.5, color: palette.textSecondary, height: 1.4),
          ),
        ],
      ),
    );
  }
}
