import 'package:flutter/material.dart';
import '../models/smart_post.dart';
import '../theme/app_theme.dart';

/// Fades in from the bottom a few seconds after its post becomes active
/// (per the Figma annotation: "The product info fades in from the bottom
/// after 3 seconds"). The whole card is tappable — it's meant to deep
/// link to the product's store page.
class ProductOverlayCard extends StatelessWidget {
  final SmartPost post;
  final bool visible;
  final VoidCallback onTap;

  const ProductOverlayCard({
    super.key,
    required this.post,
    required this.visible,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final palette = paletteOf(context);
    return AnimatedSlide(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      offset: visible ? Offset.zero : const Offset(0, 0.4),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 400),
        opacity: visible ? 1 : 0,
        child: IgnorePointer(
          ignoring: !visible,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(AppSpacing.md),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: palette.surface,
                borderRadius: BorderRadius.circular(AppSpacing.md),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.25), blurRadius: 12, offset: const Offset(0, 4)),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: post.backgroundGradient.first.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(AppSpacing.sm),
                    ),
                    child: Icon(post.productIcon, size: 20, color: post.backgroundGradient.last),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.productName,
                          style: AppText.productTitle.copyWith(color: palette.textPrimary),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                post.trending ? 'Trending right now and on sale' : post.priceLabel,
                                style: AppText.productSub.copyWith(color: palette.textSecondary),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(color: AppColors.saleGreen, borderRadius: BorderRadius.circular(6)),
                              child: Text(
                                post.discountLabel,
                                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: palette.textSecondary, size: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
