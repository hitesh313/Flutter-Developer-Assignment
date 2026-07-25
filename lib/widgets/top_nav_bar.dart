import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TopNavBar extends StatelessWidget {
  final int activeIndex;
  final List<String> tabNames;
  final ValueChanged<int> onTabTap;

  const TopNavBar({
    super.key,
    required this.activeIndex,
    required this.tabNames,
    required this.onTabTap,
  });

  @override
  Widget build(BuildContext context) {
    final palette = paletteOf(context);
    return Container(
      color: palette.surface,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _NavIconButton(icon: Icons.auto_awesome, label: 'Your Assistant', badge: 'AI', palette: palette),
              Column(
                children: [
                  Text('ORIFLAME', style: AppText.brand.copyWith(color: palette.textPrimary)),
                  const SizedBox(height: 2),
                  Text('S W E D E N', style: AppText.brandSub.copyWith(color: palette.textSecondary)),
                ],
              ),
              _NavIconButton(icon: Icons.camera_alt_outlined, label: 'Camera', palette: palette),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: List.generate(tabNames.length, (index) {
              return Padding(
                padding: EdgeInsets.only(right: index == tabNames.length - 1 ? 0 : AppSpacing.md),
                child: GestureDetector(
                  onTap: () => onTabTap(index),
                  behavior: HitTestBehavior.opaque,
                  child: _TabLabel(text: tabNames[index], active: index == activeIndex, palette: palette),
                ),
              );
            }),
          ),
          const SizedBox(height: AppSpacing.sm),
          Divider(height: 1, color: palette.divider),
        ],
      ),
    );
  }
}

class _NavIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? badge;
  final AppPalette palette;

  const _NavIconButton({required this.icon, required this.label, required this.palette, this.badge});

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
              decoration: BoxDecoration(color: palette.navIconCircle, shape: BoxShape.circle),
              child: Icon(icon, color: palette.navIconGlyph, size: 17),
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
                    border: Border.all(color: palette.surface, width: 1.2),
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
        Text(label, style: TextStyle(fontSize: 8.5, color: palette.textSecondary, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _TabLabel extends StatelessWidget {
  final String text;
  final bool active;
  final AppPalette palette;

  const _TabLabel({required this.text, required this.palette, this.active = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: active
              ? AppText.navTabActive
              : AppText.navTab.copyWith(color: palette.textSecondary),
        ),
        const SizedBox(height: 4),
        if (active)
          Container(width: 20, height: 2, decoration: BoxDecoration(color: AppColors.aiGreen, borderRadius: BorderRadius.circular(2))),
      ],
    );
  }
}
