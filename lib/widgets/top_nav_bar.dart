import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TopNavBar extends StatelessWidget {
  const TopNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _NavIconButton(
                icon: Icons.auto_awesome,
                label: 'Your Assistant',
                badge: 'AI',
              ),
              Column(
                children: const [
                  Text('ORIFLAME', style: AppText.brand),
                  SizedBox(height: 2),
                  Text('S W E D E N', style: AppText.brandSub),
                ],
              ),
              const _NavIconButton(icon: Icons.camera_alt_outlined, label: 'Camera'),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: const [
              _TabLabel(text: 'Smart Post', active: true),
              SizedBox(width: AppSpacing.md),
              _TabLabel(text: 'Library'),
              SizedBox(width: AppSpacing.md),
              _TabLabel(text: 'Communities'),
              SizedBox(width: AppSpacing.md),
              _TabLabel(text: 'Share&Win'),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          const Divider(height: 1, color: AppColors.divider),
        ],
      ),
    );
  }
}

class _NavIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? badge;

  const _NavIconButton({required this.icon, required this.label, this.badge});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: const BoxDecoration(
                color: AppColors.black,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 17),
            ),
            if (badge != null)
              Positioned(
                right: -4,
                top: -4,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    color: AppColors.aiGreen,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.white, width: 1.2),
                  ),
                  child: Text(
                    badge!,
                    style: const TextStyle(fontSize: 7, fontWeight: FontWeight.w800, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 3),
        Text(label, style: const TextStyle(fontSize: 8.5, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _TabLabel extends StatelessWidget {
  final String text;
  final bool active;

  const _TabLabel({required this.text, this.active = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: active ? AppText.navTabActive : AppText.navTab),
        const SizedBox(height: 4),
        if (active)
          Container(width: 20, height: 2, decoration: BoxDecoration(color: AppColors.aiGreen, borderRadius: BorderRadius.circular(2))),
      ],
    );
  }
}
