import 'dart:async';
import 'package:flutter/material.dart';
import '../data/demo_data.dart';
import '../models/smart_post.dart';
import '../services/caption_storage_service.dart';
import '../theme/app_theme.dart';
import '../widgets/one_at_a_time_pager.dart';
import '../widgets/post_page.dart';
import '../widgets/share_progress_dialog.dart';
import '../widgets/skeleton_post_card.dart';
import 'edit_caption_screen.dart';

class SmartPostFeed extends StatefulWidget {
  const SmartPostFeed({super.key});

  @override
  State<SmartPostFeed> createState() => _SmartPostFeedState();
}

class _SmartPostFeedState extends State<SmartPostFeed> {
  final _postController = OneAtATimePagerController();
  final _storage = CaptionStorageService();
  final Set<int> _productVisible = {};
  Timer? _revealTimer;
  late List<String> _captions;
  bool _showSkeleton = true;

  @override
  void initState() {
    super.initState();
    _captions = DemoData.posts.map((p) => p.caption).toList();
    _postController.addListener(_onPostChanged);
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    // Restore any locally-saved edits and the last post the user was on.
    for (int i = 0; i < _captions.length; i++) {
      final saved = await _storage.loadCaption(i);
      if (saved != null) _captions[i] = saved;
    }
    final lastIndex = await _storage.loadLastPostIndex();
    if (lastIndex != null && lastIndex < DemoData.posts.length) {
      _postController.jumpTo(lastIndex);
    }

    // Brief skeleton state before the real content is revealed.
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _showSkeleton = false);
    _scheduleReveal(_postController.index);
  }

  void _onPostChanged() {
    _scheduleReveal(_postController.index);
    _storage.saveLastPostIndex(_postController.index);
  }

  void _scheduleReveal(int index) {
    _revealTimer?.cancel();
    if (_productVisible.contains(index)) return;
    _revealTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) setState(() => _productVisible.add(index));
    });
  }

  @override
  void dispose() {
    _postController.removeListener(_onPostChanged);
    _postController.dispose();
    _revealTimer?.cancel();
    super.dispose();
  }

  Future<void> _openEditCaption(int index) async {
    final result = await Navigator.of(context).push<String>(
      MaterialPageRoute(builder: (_) => EditCaptionScreen(initialCaption: _captions[index])),
    );
    if (result != null && mounted) {
      setState(() => _captions[index] = result);
      await _storage.saveCaption(index, result);
    }
  }

  void _handleQuickShare(QuickShareApp app) {
    showShareProgress(context, app);
  }

  void _handleProductTap(SmartPost post) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening ${post.productName} in the store \u2014 demo only'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.black,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_showSkeleton) return const SkeletonPostCard();

    return OneAtATimePager(
      controller: _postController,
      itemCount: DemoData.posts.length,
      axis: Axis.vertical,
      itemBuilder: (context, index) {
        final post = DemoData.posts[index];
        return PostPage(
          post: post,
          index: index,
          total: DemoData.posts.length,
          caption: _captions[index],
          productVisible: _productVisible.contains(index),
          onEditCaption: () => _openEditCaption(index),
          onQuickShare: _handleQuickShare,
          onProductTap: () => _handleProductTap(post),
        );
      },
    );
  }
}
