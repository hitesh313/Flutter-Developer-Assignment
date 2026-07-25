import 'package:flutter/material.dart';
import '../models/share_models.dart';
import '../theme/app_theme.dart';

/// A single app/action tile in the "share to" grid, e.g. WhatsApp,
/// Instagram, Copy Link.
class DestinationTile extends StatelessWidget {
  final ShareDestination destination;
  final VoidCallback onTap;

  const DestinationTile({
    super.key,
    required this.destination,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: destination.color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(destination.icon, color: destination.color, size: 24),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              destination.label,
              style: AppTextStyles.caption,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
