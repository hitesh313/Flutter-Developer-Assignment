import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  static const _icons = [
    Icons.explore_outlined,
    Icons.search,
    Icons.home_outlined,
    Icons.chat_bubble_outline,
    Icons.person_outline,
  ];
  static const _activeIndex = 2;

  @override
  Widget build(BuildContext context) {
    final palette = paletteOf(context);
    return Container(
      color: palette.surface,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(_icons.length, (index) {
            final bool active = index == _activeIndex;
            final Color color = active ? palette.textPrimary : palette.textSecondary;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(_icons[index], size: 24, color: color),
                const SizedBox(height: 4),
                Container(
                  width: 16,
                  height: 2,
                  decoration: BoxDecoration(
                    color: active ? palette.textPrimary : Colors.transparent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
