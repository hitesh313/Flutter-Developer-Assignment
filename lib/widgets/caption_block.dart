import 'package:flutter/material.dart';
import '../models/smart_post.dart';
import '../theme/app_theme.dart';

class CaptionBlock extends StatefulWidget {
  final SmartPost post;
  final String caption;
  final VoidCallback onEditCaption;

  const CaptionBlock({
    super.key,
    required this.post,
    required this.caption,
    required this.onEditCaption,
  });

  @override
  State<CaptionBlock> createState() => _CaptionBlockState();
}

class _CaptionBlockState extends State<CaptionBlock> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Icon(Icons.music_note, size: 14, color: Colors.white),
            const SizedBox(width: 4),
            Expanded(
              child: Text.rich(
                TextSpan(
                  style: const TextStyle(fontSize: 11.5, color: Colors.white),
                  children: [
                    const TextSpan(text: 'Recommended: '),
                    TextSpan(text: post.songTitle, style: const TextStyle(fontWeight: FontWeight.w700)),
                    TextSpan(text: ' by ${post.songArtist}'),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(Icons.auto_awesome, size: 12, color: Colors.white70),
                SizedBox(width: 4),
                Text('CAPTION SUGGESTION', style: AppText.captionLabel),
              ],
            ),
            InkWell(
              onTap: widget.onEditCaption,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.edit, size: 13, color: Colors.white),
                  SizedBox(width: 4),
                  Text('Edit Caption', style: AppText.editCaptionLink),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: '${widget.caption}\n', style: AppText.body),
                TextSpan(text: '${post.hashtags}\n', style: AppText.body.copyWith(fontWeight: FontWeight.w600)),
                TextSpan(text: 'Use my referral code: ${post.referralCode}\n', style: AppText.referral),
                TextSpan(text: 'Use my referral link: ${post.referralLink}', style: AppText.referral),
              ],
            ),
            maxLines: _expanded ? null : 3,
            overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
          ),
        ),
        if (!_expanded)
          GestureDetector(
            onTap: () => setState(() => _expanded = true),
            child: const Padding(
              padding: EdgeInsets.only(top: 2),
              child: Text('See more', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: Colors.white)),
            ),
          ),
      ],
    );
  }
}
