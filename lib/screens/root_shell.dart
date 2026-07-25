import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/one_at_a_time_pager.dart';
import '../widgets/top_nav_bar.dart';
import 'placeholder_tab_page.dart';
import 'smart_post_feed.dart';

/// Top-level shell: fixed top/bottom nav around a horizontally-swipeable
/// set of tabs (Smart Post / Library / Communities / Share&Win). Only
/// Smart Post has a real design; the rest show [PlaceholderTabPage].
/// Horizontal swipe changes which tab you're on; inside Smart Post,
/// vertical swipe changes which post you're viewing — each axis owned
/// by its own [OneAtATimePagerController].
class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  static const _tabNames = ['Smart Post', 'Library', 'Communities', 'Share&Win'];
  final _tabController = OneAtATimePagerController();

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = paletteOf(context);
    return Scaffold(
      backgroundColor: palette.scaffoldBg,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _tabController,
          builder: (context, _) {
            return Column(
              children: [
                TopNavBar(
                  activeIndex: _tabController.index,
                  tabNames: _tabNames,
                  onTabTap: _tabController.jumpTo,
                ),
                Expanded(
                  child: OneAtATimePager(
                    controller: _tabController,
                    itemCount: _tabNames.length,
                    axis: Axis.horizontal,
                    itemBuilder: (context, index) {
                      if (index == 0) return const SmartPostFeed();
                      return PlaceholderTabPage(name: _tabNames[index]);
                    },
                  ),
                ),
                const BottomNavBar(),
              ],
            );
          },
        ),
      ),
    );
  }
}
