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
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(_icons.length, (index) {
            final bool active = index == _activeIndex;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(_icons[index], size: 24, color: active ? AppColors.black : AppColors.textSecondary),
                const SizedBox(height: 4),
                Container(
                  width: 16,
                  height: 2,
                  decoration: BoxDecoration(
                    color: active ? AppColors.black : Colors.transparent,
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
