import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A single shimmering placeholder box. Self-contained animation so it
/// can be dropped anywhere a piece of content is still loading, without
/// pulling in an external shimmer package.
class SkeletonBox extends StatefulWidget {
  final double? width;
  final double height;
  final BorderRadius borderRadius;

  const SkeletonBox({
    super.key,
    this.width,
    this.height = 14,
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
  });

  @override
  State<SkeletonBox> createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<SkeletonBox> with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 1300))..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = paletteOf(context);
    final base = palette.divider;
    final highlight = palette.textSecondary.withValues(alpha: 0.18);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final t = _controller.value;
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            gradient: LinearGradient(
              begin: Alignment(-1.5 + t * 3, 0),
              end: Alignment(-0.5 + t * 3, 0),
              colors: [base, highlight, base],
            ),
          ),
        );
      },
    );
  }
}
