import 'package:flutter/material.dart';
import '../models/smart_post.dart';
import '../theme/app_theme.dart';
import 'badges_and_dots.dart';
import 'caption_block.dart';
import 'product_overlay_card.dart';
import 'quick_share_row.dart';

/// A single full-bleed Smart Post card: photo, "Ready to share" badge,
/// delayed product overlay, caption block, and quick-share row. Content
/// drawn over the photo stays white-on-scrim regardless of the device's
/// light/dark setting, matching how photo content behaves in real social
/// apps — only the surrounding app chrome adapts to system theme.
class PostPage extends StatelessWidget {
  final SmartPost post;
  final int index;
  final int total;
  final String caption;
  final bool productVisible;
  final VoidCallback onEditCaption;
  final void Function(QuickShareApp app) onQuickShare;
  final VoidCallback onProductTap;

  const PostPage({
    super.key,
    required this.post,
    required this.index,
    required this.total,
    required this.caption,
    required this.productVisible,
    required this.onEditCaption,
    required this.onQuickShare,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Placeholder for the real product photo — see README.
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: post.backgroundGradient,
            ),
          ),
          child: Center(
            child: Icon(post.heroIcon, size: 96, color: Colors.white.withValues(alpha: 0.25)),
          ),
        ),
        // Scrim so text stays legible over the photo.
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black.withValues(alpha: 0.0), Colors.black.withValues(alpha: 0.75)],
              stops: const [0.45, 1.0],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(radius: 16, backgroundColor: post.creatorAvatarColor, child: Text(post.creatorInitial, style: AppText.nameLabel)),
                  const SizedBox(width: AppSpacing.sm),
                  const ReadyToShareBadge(),
                  const Spacer(),
                  Text('${index + 1} of $total', style: const TextStyle(fontSize: 11, color: Colors.white70, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 44),
                child: Text(post.communityLine, style: AppText.communityLine),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: PageDotsIndicator(count: total, activeIndex: index),
              ),
              const SizedBox(height: AppSpacing.sm),
              ProductOverlayCard(post: post, visible: productVisible, onTap: onProductTap),
              const SizedBox(height: AppSpacing.md),
              CaptionBlock(post: post, caption: caption, onEditCaption: onEditCaption),
              const SizedBox(height: AppSpacing.md),
              QuickShareRow(onTapApp: onQuickShare),
            ],
          ),
        ),
      ],
    );
  }
}
