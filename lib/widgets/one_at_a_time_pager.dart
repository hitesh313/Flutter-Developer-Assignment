import 'package:flutter/material.dart';

/// Tracks the current index for a [OneAtATimePager]. Exposed separately
/// so a parent (e.g. a tab bar) can also jump the pager directly, not
/// just via swipe.
class OneAtATimePagerController extends ChangeNotifier {
  OneAtATimePagerController({int initialIndex = 0}) : _index = initialIndex;

  int _index;
  int get index => _index;

  /// Jump straight to [newIndex] (e.g. from a tab tap).
  void jumpTo(int newIndex) {
    if (newIndex == _index) return;
    _index = newIndex;
    notifyListeners();
  }

  /// Move by [delta] (+1 / -1), clamped to `[0, itemCount - 1]`.
  void step(int delta, int itemCount) {
    final next = (_index + delta).clamp(0, itemCount - 1);
    jumpTo(next);
  }
}

/// A single-axis pager that advances **exactly one item per completed
/// swipe**, no matter how fast or far the gesture travels — a fast
/// multi-page fling still only steps once. A short lock while the
/// transition animates means a rapid string of swipes gets queued up
/// one at a time rather than skipping ahead.
///
/// Reused for both the horizontal top-level tab switch (Smart Post /
/// Library / Communities / Share&Win) and the vertical reel-style post
/// scroll, so the "one at a time" behaviour only has to be implemented
/// once.
class OneAtATimePager extends StatefulWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final Axis axis;
  final OneAtATimePagerController controller;
  final Duration animationDuration;

  const OneAtATimePager({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.controller,
    this.axis = Axis.vertical,
    this.animationDuration = const Duration(milliseconds: 320),
  });

  @override
  State<OneAtATimePager> createState() => _OneAtATimePagerState();
}

class _OneAtATimePagerState extends State<OneAtATimePager> {
  static const double _dragThreshold = 56;

  double _dragAccum = 0;
  bool _locked = false;
  int _lastDirection = 1;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    super.dispose();
  }

  void _onControllerChanged() {
    setState(() => _locked = true);
    Future.delayed(widget.animationDuration, () {
      if (mounted) setState(() => _locked = false);
    });
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    final delta = widget.axis == Axis.vertical ? details.delta.dy : details.delta.dx;
    _dragAccum += delta;
  }

  void _handleDragEnd(DragEndDetails details) {
    final accum = _dragAccum;
    _dragAccum = 0;
    if (_locked) return;
    if (accum <= -_dragThreshold) {
      _lastDirection = 1;
      widget.controller.step(1, widget.itemCount);
    } else if (accum >= _dragThreshold) {
      _lastDirection = -1;
      widget.controller.step(-1, widget.itemCount);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool vertical = widget.axis == Axis.vertical;
    return GestureDetector(
      onVerticalDragUpdate: vertical ? _handleDragUpdate : null,
      onVerticalDragEnd: vertical ? _handleDragEnd : null,
      onHorizontalDragUpdate: !vertical ? _handleDragUpdate : null,
      onHorizontalDragEnd: !vertical ? _handleDragEnd : null,
      child: AnimatedSwitcher(
        duration: widget.animationDuration,
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (child, animation) {
          final offset = vertical
              ? Offset(0, 0.08 * _lastDirection)
              : Offset(0.08 * _lastDirection, 0);
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(begin: offset, end: Offset.zero).animate(animation),
              child: child,
            ),
          );
        },
        child: KeyedSubtree(
          key: ValueKey(widget.controller.index),
          child: widget.itemBuilder(context, widget.controller.index),
        ),
      ),
    );
  }
}
