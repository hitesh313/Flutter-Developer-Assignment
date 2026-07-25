import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ReadyToShareBadge extends StatelessWidget {
  const ReadyToShareBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.readyPinkStart, AppColors.readyPinkEnd]),
        borderRadius: BorderRadius.circular(AppSpacing.md),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.auto_awesome, size: 11, color: Colors.white),
          SizedBox(width: 4),
          Text('Ready to share', style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: Colors.white)),
        ],
      ),
    );
  }
}

/// The stack of small dots on the right edge signalling how many more
/// posts can be swiped through, reel-style.
class PageDotsIndicator extends StatelessWidget {
  final int count;
  final int activeIndex;

  const PageDotsIndicator({super.key, required this.count, required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final bool active = index == activeIndex;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Container(
            width: active ? 7 : 5,
            height: active ? 7 : 5,
            decoration: BoxDecoration(
              color: active ? AppColors.aiGreen : Colors.white.withValues(alpha: 0.55),
              shape: BoxShape.circle,
            ),
          ),
        );
      }),
    );
  }
}
