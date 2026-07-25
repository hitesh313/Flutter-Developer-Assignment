import 'dart:async';
import 'package:flutter/material.dart';
import '../data/demo_data.dart';
import '../theme/app_theme.dart';
import 'root_shell.dart';

/// The splash/build screen shown while the AI assembles the Smart Posts.
/// Automatically follows the device's light/dark setting via
/// `MaterialApp(themeMode: ThemeMode.system)` — no manual switch needed;
/// this is exactly the frame the Figma file designs for both modes.
class BuildingSmartPostsScreen extends StatefulWidget {
  const BuildingSmartPostsScreen({super.key});

  @override
  State<BuildingSmartPostsScreen> createState() => _BuildingSmartPostsScreenState();
}

class _BuildingSmartPostsScreenState extends State<BuildingSmartPostsScreen> {
  int _completedSteps = 0;
  bool _allDone = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _runSequence();
  }

  void _runSequence() {
    _timer = Timer.periodic(const Duration(milliseconds: 650), (timer) {
      if (_completedSteps < DemoData.buildingSteps.length) {
        setState(() => _completedSteps++);
      } else {
        timer.cancel();
        setState(() => _allDone = true);
        Future.delayed(const Duration(milliseconds: 700), () {
          if (mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const RootShell()),
            );
          }
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
    final palette = paletteOf(context);

    return Scaffold(
      backgroundColor: palette.scaffoldBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 2),
              Text(
                'Building personalised\nSmart Posts for you!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: palette.textPrimary, height: 1.3),
              ),
              const SizedBox(height: AppSpacing.xl),
              ...List.generate(DemoData.buildingSteps.length, (index) {
                final bool done = index < _completedSteps;
                final bool inProgress = index == _completedSteps && !_allDone;
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: Row(
                    children: [
                      _StepIcon(done: done, inProgress: inProgress, palette: palette),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          DemoData.buildingSteps[index],
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w500,
                            color: done || inProgress ? palette.textPrimary : palette.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: AppSpacing.sm),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _allDone ? 1 : 0,
                child: Text('All set! Get ready to share...', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: palette.textSecondary)),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}

class _StepIcon extends StatelessWidget {
  final bool done;
  final bool inProgress;
  final AppPalette palette;

  const _StepIcon({required this.done, required this.inProgress, required this.palette});

  @override
  Widget build(BuildContext context) {
    if (done) {
      return const Icon(Icons.check_circle, size: 20, color: AppColors.aiGreen);
    }
    if (inProgress) {
      return const SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.aiGreen),
      );
    }
    return Icon(Icons.circle_outlined, size: 20, color: palette.textSecondary.withValues(alpha: 0.5));
  }
}
