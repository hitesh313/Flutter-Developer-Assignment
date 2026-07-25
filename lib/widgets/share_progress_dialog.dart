import 'dart:async';
import 'package:flutter/material.dart';
import '../data/demo_data.dart';
import '../models/smart_post.dart';
import '../theme/app_theme.dart';

/// Shows the "Generating your sales link... / Copying caption... /
/// Saving... / Preparing for social media..." sequence from the Figma
/// loading panel, then a brief "opening app" hand-off screen before
/// closing itself.
Future<void> showShareProgress(BuildContext context, QuickShareApp app) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black54,
    builder: (_) => ShareProgressDialog(app: app),
  );
}

class ShareProgressDialog extends StatefulWidget {
  final QuickShareApp app;
  const ShareProgressDialog({super.key, required this.app});

  @override
  State<ShareProgressDialog> createState() => _ShareProgressDialogState();
}

class _ShareProgressDialogState extends State<ShareProgressDialog> {
  int _completed = 0;
  bool _handoff = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 550), (timer) {
      if (_completed < DemoData.shareSteps.length) {
        setState(() => _completed++);
      } else {
        timer.cancel();
        setState(() => _handoff = true);
        Future.delayed(const Duration(milliseconds: 900), () {
          if (mounted) Navigator.of(context).pop();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.lg),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _handoff ? _HandoffCard(app: widget.app) : _StepsCard(completed: _completed),
        ),
      ),
    );
  }
}

class _StepsCard extends StatelessWidget {
  final int completed;
  const _StepsCard({required this.completed});

  @override
  Widget build(BuildContext context) {
    final palette = paletteOf(context);
    return Container(
      key: const ValueKey('steps'),
      color: palette.surface,
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(DemoData.shareSteps.length, (index) {
          final bool done = index < completed;
          final bool active = index == completed;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Row(
              children: [
                if (done)
                  const Icon(Icons.check_circle, color: AppColors.aiGreen, size: 20)
                else if (active)
                  const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.aiGreen),
                  )
                else
                  Icon(Icons.circle_outlined, size: 20, color: palette.divider),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    DemoData.shareSteps[index],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: done || active ? palette.textPrimary : palette.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _HandoffCard extends StatelessWidget {
  final QuickShareApp app;
  const _HandoffCard({required this.app});

  @override
  Widget build(BuildContext context) {
    final palette = paletteOf(context);
    return Container(
      key: const ValueKey('handoff'),
      height: 180,
      color: palette.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(gradient: LinearGradient(colors: app.gradient), shape: BoxShape.circle),
            child: Icon(app.icon, color: Colors.white, size: 26),
          ),
          const SizedBox(height: AppSpacing.md),
          Text('Opening ${app.label}\u2026', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: palette.textPrimary)),
        ],
      ),
    );
  }
}
