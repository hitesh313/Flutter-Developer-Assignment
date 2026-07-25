import 'dart:async';
import 'package:flutter/material.dart';
import '../data/demo_data.dart';
import '../models/smart_post.dart';
import '../theme/app_theme.dart';
import '../widgets/badges_and_dots.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/caption_block.dart';
import '../widgets/product_overlay_card.dart';
import '../widgets/quick_share_row.dart';
import '../widgets/share_progress_dialog.dart';
import '../widgets/top_nav_bar.dart';
import 'edit_caption_screen.dart';

class SmartPostScreen extends StatefulWidget {
  const SmartPostScreen({super.key});

  @override
  State<SmartPostScreen> createState() => _SmartPostScreenState();
}

class _SmartPostScreenState extends State<SmartPostScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final Set<int> _productVisible = {};
  late List<String> _captions;
  Timer? _revealTimer;

  @override
  void initState() {
    super.initState();
    _captions = DemoData.posts.map((p) => p.caption).toList();
    _scheduleReveal(0);
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
    _pageController.dispose();
    _revealTimer?.cancel();
    super.dispose();
  }

  Future<void> _openEditCaption(int index) async {
    final result = await Navigator.of(context).push<String>(
      MaterialPageRoute(builder: (_) => EditCaptionScreen(initialCaption: _captions[index])),
    );
    if (result != null && mounted) {
      setState(() => _captions[index] = result);
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
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            const TopNavBar(),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                itemCount: DemoData.posts.length,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                  _scheduleReveal(index);
                },
                itemBuilder: (context, index) {
                  final post = DemoData.posts[index];
                  return _PostPage(
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
              ),
            ),
            const BottomNavBar(),
          ],
        ),
      ),
    );
  }
}

class _PostPage extends StatelessWidget {
  final SmartPost post;
  final int index;
  final int total;
  final String caption;
  final bool productVisible;
  final VoidCallback onEditCaption;
  final void Function(QuickShareApp app) onQuickShare;
  final VoidCallback onProductTap;

  const _PostPage({
    required this.post,
    required this.index,
    required this.total,
    required this.caption,
    required this.productVisible,
    required this.onEditCaption,
    required this.onQuickShare,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Placeholder for the real product photo — see README.
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: post.backgroundGradient,
            ),
          ),
          child: Center(
            child: Icon(post.heroIcon, size: 96, color: Colors.white.withValues(alpha: 0.25)),
          ),
        ),
        // Scrim so text stays legible over the photo.
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black.withValues(alpha: 0.0), Colors.black.withValues(alpha: 0.75)],
              stops: const [0.45, 1.0],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(radius: 16, backgroundColor: post.creatorAvatarColor, child: Text(post.creatorInitial, style: AppText.nameLabel)),
                  const SizedBox(width: AppSpacing.sm),
                  const ReadyToShareBadge(),
                  const Spacer(),
                  Text('${index + 1} of $total', style: const TextStyle(fontSize: 11, color: Colors.white70, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 44),
                child: Text(post.communityLine, style: AppText.communityLine),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: PageDotsIndicator(count: total, activeIndex: index),
              ),
              const SizedBox(height: AppSpacing.sm),
              ProductOverlayCard(post: post, visible: productVisible, onTap: onProductTap),
              const SizedBox(height: AppSpacing.md),
              CaptionBlock(post: post, caption: caption, onEditCaption: onEditCaption),
              const SizedBox(height: AppSpacing.md),
              QuickShareRow(onTapApp: onQuickShare),
            ],
          ),
        ),
      ],
    );
  }
}
