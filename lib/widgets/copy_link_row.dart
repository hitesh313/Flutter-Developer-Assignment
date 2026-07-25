import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

/// A pill-shaped row showing the shareable link with a "Copy" action.
/// Gives clear tap feedback by swapping the button label briefly —
/// a small UX touch not spelled out by the brief but expected of a
/// share sheet.
class CopyLinkRow extends StatefulWidget {
  final String link;

  const CopyLinkRow({super.key, required this.link});

  @override
  State<CopyLinkRow> createState() => _CopyLinkRowState();
}

class _CopyLinkRowState extends State<CopyLinkRow> {
  bool _copied = false;

  void _handleCopy() async {
    await Clipboard.setData(ClipboardData(text: widget.link));
    setState(() => _copied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          const Icon(Icons.link, size: 18, color: AppColors.textSecondary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              widget.link,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          GestureDetector(
            onTap: _handleCopy,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              child: Text(
                _copied ? 'Copied' : 'Copy',
                key: ValueKey(_copied),
                style: AppTextStyles.label.copyWith(
                  color: _copied ? AppColors.success : AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
