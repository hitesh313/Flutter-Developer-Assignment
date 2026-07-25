import 'package:flutter/material.dart';
import '../data/demo_data.dart';
import '../theme/app_theme.dart';
import '../widgets/contact_avatar.dart';
import '../widgets/copy_link_row.dart';
import '../widgets/destination_tile.dart';
import '../widgets/post_preview_card.dart';

/// The Quick Share screen: preview what's being shared, pick people to
/// send it to directly, or share out to another app / copy the link.
///
/// Presented as a full screen here so it's easy to demo standalone; in
/// a real app this same content would also work dropped into a
/// DraggableScrollableSheet / showModalBottomSheet.
class QuickShareScreen extends StatefulWidget {
  const QuickShareScreen({super.key});

  @override
  State<QuickShareScreen> createState() => _QuickShareScreenState();
}

class _QuickShareScreenState extends State<QuickShareScreen> {
  final Set<String> _selectedContactIds = {};

  void _toggleContact(String id) {
    setState(() {
      if (_selectedContactIds.contains(id)) {
        _selectedContactIds.remove(id);
      } else {
        _selectedContactIds.add(id);
      }
    });
  }

  void _handleDestinationTap(String label) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing to $label \u2014 demo only'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.textPrimary,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool hasSelection = _selectedContactIds.isNotEmpty;
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWide = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Share'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {},
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isWide ? 480 : double.infinity),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      AppSpacing.md,
                      AppSpacing.md,
                      AppSpacing.lg,
                    ),
                    children: [
                      PostPreviewCard(post: DemoData.post),
                      const SizedBox(height: AppSpacing.lg),

                      Text('Quick share to', style: AppTextStyles.heading.copyWith(fontSize: 16)),
                      const SizedBox(height: AppSpacing.md),
                      SizedBox(
                        height: 92,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: DemoData.contacts.length,
                          separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
                          itemBuilder: (context, index) {
                            final contact = DemoData.contacts[index];
                            return ContactAvatar(
                              contact: contact,
                              selected: _selectedContactIds.contains(contact.id),
                              onTap: () => _toggleContact(contact.id),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      Text('Share via', style: AppTextStyles.heading.copyWith(fontSize: 16)),
                      const SizedBox(height: AppSpacing.sm),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: DemoData.destinations.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: AppSpacing.xs,
                        ),
                        itemBuilder: (context, index) {
                          final destination = DemoData.destinations[index];
                          return DestinationTile(
                            destination: destination,
                            onTap: () => _handleDestinationTap(destination.label),
                          );
                        },
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      Text('Or copy link', style: AppTextStyles.heading.copyWith(fontSize: 16)),
                      const SizedBox(height: AppSpacing.sm),
                      CopyLinkRow(link: DemoData.shareLink),
                    ],
                  ),
                ),

                // Bottom action bar — only meaningful once contacts are
                // picked, so it's disabled/hidden state otherwise.
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: const BoxDecoration(
                    color: AppColors.surface,
                    border: Border(top: BorderSide(color: AppColors.divider)),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: hasSelection
                          ? () => _handleDestinationTap(
                              '${_selectedContactIds.length} '
                              '${_selectedContactIds.length == 1 ? 'contact' : 'contacts'}')
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        disabledBackgroundColor: AppColors.divider,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        hasSelection
                            ? 'Send to ${_selectedContactIds.length} selected'
                            : 'Select contacts to send',
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
