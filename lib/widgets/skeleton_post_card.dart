import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'skeleton_box.dart';

/// Mirrors the layout of a real post card so the skeleton-to-content
/// swap doesn't visually jump around once the real post fades in.
class SkeletonPostCard extends StatelessWidget {
  const SkeletonPostCard({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = paletteOf(context);
    return Container(
      color: palette.scaffoldBg,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              SkeletonBox(width: 32, height: 32, borderRadius: BorderRadius.all(Radius.circular(16))),
              SizedBox(width: AppSpacing.sm),
              SkeletonBox(width: 110, height: 18, borderRadius: BorderRadius.all(Radius.circular(10))),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const Expanded(
            child: SkeletonBox(height: double.infinity, borderRadius: BorderRadius.all(Radius.circular(AppSpacing.md))),
          ),
          const SizedBox(height: AppSpacing.md),
          const SkeletonBox(width: double.infinity, height: 54, borderRadius: BorderRadius.all(Radius.circular(AppSpacing.md))),
          const SizedBox(height: AppSpacing.md),
          const SkeletonBox(width: double.infinity, height: 12),
          const SizedBox(height: AppSpacing.sm),
          const SkeletonBox(width: 220, height: 12),
          const SizedBox(height: AppSpacing.sm),
          const SkeletonBox(width: 160, height: 12),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: List.generate(
              6,
              (i) => Padding(
                padding: const EdgeInsets.only(right: AppSpacing.sm),
                child: SkeletonBox(width: 32, height: 32, borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
