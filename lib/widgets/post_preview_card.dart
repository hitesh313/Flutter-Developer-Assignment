import 'package:flutter/material.dart';
import '../models/share_models.dart';
import '../theme/app_theme.dart';

/// Shows a compact preview of the post being shared, so the user has
/// context on what they're about to send before picking a destination.
class PostPreviewCard extends StatelessWidget {
  final SharePost post;

  const PostPreviewCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.md),
            child: Container(
              width: 56,
              height: 56,
              color: post.mediaColor.withValues(alpha: 0.85),
              child: const Icon(Icons.image, color: Colors.white, size: 24),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 9,
                      backgroundColor: post.authorColor,
                      child: Text(
                        post.authorName.substring(0, 1),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(post.authorName, style: AppTextStyles.label),
                    const SizedBox(width: AppSpacing.xs),
                    Text('\u2022', style: AppTextStyles.caption),
                    const SizedBox(width: AppSpacing.xs),
                    Text(post.timeAgo, style: AppTextStyles.caption),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  post.caption,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.body.copyWith(height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
