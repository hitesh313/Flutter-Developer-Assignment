import 'dart:async';
import 'package:flutter/material.dart';
import '../data/demo_data.dart';
import '../theme/app_theme.dart';
import 'smart_post_screen.dart';


/// The splash/build screen shown while the AI assembles the Smart Posts.
/// The Figma file shows this in both a light and a dark variant — a
/// small toggle in the corner lets you preview both, which felt like a
/// nice touch to demonstrate rather than just picking one.
class BuildingSmartPostsScreen extends StatefulWidget {
  const BuildingSmartPostsScreen({super.key});

  @override
  State<BuildingSmartPostsScreen> createState() => _BuildingSmartPostsScreenState();
}

class _BuildingSmartPostsScreenState extends State<BuildingSmartPostsScreen> {
  bool _isDark = false;
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
              MaterialPageRoute(builder: (_) => const SmartPostScreen()),
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
    final bg = _isDark ? AppColors.darkBg : AppColors.white;
    final titleColor = _isDark ? Colors.white : AppColors.black;
    final subColor = _isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () => setState(() => _isDark = !_isDark),
                  icon: Icon(_isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined, color: subColor),
                ),
              ),
              const Spacer(),
              Text(
                'Building personalised\nSmart Posts for you!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: titleColor, height: 1.3),
              ),
              const SizedBox(height: AppSpacing.xl),
              ...List.generate(DemoData.buildingSteps.length, (index) {
                final bool done = index < _completedSteps;
                final bool inProgress = index == _completedSteps && !_allDone;
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: Row(
                    children: [
                      _StepIcon(done: done, inProgress: inProgress, subColor: subColor),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          DemoData.buildingSteps[index],
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w500,
                            color: done || inProgress ? titleColor : subColor,
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
                child: Text('All set! Get ready to share...', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: subColor)),
              ),
              const Spacer(flex: 2),
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
  final Color subColor;

  const _StepIcon({required this.done, required this.inProgress, required this.subColor});

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
    return Icon(Icons.circle_outlined, size: 20, color: subColor.withValues(alpha: 0.5));
  }
}
