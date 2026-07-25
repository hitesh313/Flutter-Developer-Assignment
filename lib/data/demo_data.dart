import 'package:flutter/material.dart';
import '../models/smart_post.dart';
import '../theme/app_theme.dart';

class DemoData {
  DemoData._();

  static final List<SmartPost> posts = [
    SmartPost(
      creatorInitial: 'A',
      creatorAvatarColor: const Color(0xFFE8A87C),
      communityLine: 'High-converting in Oriflame Community',
      backgroundGradient: const [Color(0xFF8B5E3C), Color(0xFF3D2A1F)],
      heroIcon: Icons.brush,
      productIcon: Icons.brush,
      productName: 'Giordani Gold Lipstick',
      priceLabel: '\$14.99',
      discountLabel: '30% off',
      trending: false,
      songTitle: 'Bad Habits',
      songArtist: 'Ed Sheeran',
      caption:
          'Elevate your beauty with the Giordani Gold - Eternal Glow '
          'Lipstick SPF 25! This luxurious creamy lipstick doesn\'t just '
          'promise rich pigments but brings you the benefits of hyaluronic '
          'acid and collagen-boosting peptides too. Pamper your lips with '
          'care while enjoying a long-lasting, luminous matte colour.',
      hashtags: '#Oriflame #GiordaniGold #LipCareGoals',
      referralCode: 'UK-AMANDA3012',
      referralLink: 'www.oriflame.com/giordani/amanda3012',
    ),
    SmartPost(
      creatorInitial: 'A',
      creatorAvatarColor: const Color(0xFFE8A87C),
      communityLine: 'High-converting in Oriflame Community',
      backgroundGradient: const [Color(0xFFE8C7C7), Color(0xFF7A4B4B)],
      heroIcon: Icons.local_florist,
      productIcon: Icons.local_florist,
      productName: 'Eclat Amour',
      priceLabel: '\$32.00',
      discountLabel: '20% off',
      trending: true,
      songTitle: 'Unstoppable',
      songArtist: 'Sia',
      caption:
          'Experience the elegance of Eclat Amour \u2014 a fragrance that '
          'captures the essence of romance and sophistication. Let every '
          'spritz wrap you in timeless charm and effortless allure.',
      hashtags: '#EclatAmour #TimelessElegance',
      referralCode: 'UK-AMANDA3012',
      referralLink: 'www.oriflame.com/giordani/amanda3012',
    ),
    SmartPost(
      creatorInitial: 'A',
      creatorAvatarColor: const Color(0xFFE8A87C),
      communityLine: 'High-converting in Oriflame Community',
      backgroundGradient: const [Color(0xFFF4B6D2), Color(0xFF6B2C57)],
      heroIcon: Icons.auto_awesome,
      productIcon: Icons.auto_awesome,
      productName: 'WonderLash Mascara',
      priceLabel: '\$18.50',
      discountLabel: '15% off',
      trending: false,
      songTitle: 'Vogue',
      songArtist: 'Madonna',
      caption:
          'Unlock the power of bold, beautiful lashes! With WonderLash '
          'Mascara, get ultimate length, volume, and definition for a '
          'stunning, eye-catching look. One swipe is all it takes!',
      hashtags: '#WonderLash #LashesForDays',
      referralCode: 'UK-AMANDA3012',
      referralLink: 'www.oriflame.com/giordani/amanda3012',
    ),
  ];

  /// Steps for the "Building personalised Smart Posts for you!" loader.
  static const List<String> buildingSteps = [
    'Preparing popular content for you',
    'Crafting a caption to boost engagement',
    'Adding your personal referral link and code',
    'Finding trending songs on other social media',
  ];

  /// Steps shown while a Quick Share is being prepared.
  static const List<String> shareSteps = [
    'Generating your sales link',
    'Copying the caption to clipboard',
    'Saving the content to your profile',
    'Preparing the content for social media',
  ];

  static const List<QuickShareApp> quickShareApps = [
    QuickShareApp(
      label: 'Instagram Feed',
      icon: Icons.camera_alt,
      gradient: [AppColors.instagramStart, AppColors.instagramMid, AppColors.instagramEnd],
    ),
    QuickShareApp(
      label: 'Instagram Story',
      icon: Icons.add_circle,
      gradient: [AppColors.instagramStart, AppColors.instagramMid, AppColors.instagramEnd],
    ),
    QuickShareApp(
      label: 'Facebook Feed',
      icon: Icons.facebook,
      gradient: [AppColors.facebook, AppColors.facebook],
    ),
    QuickShareApp(
      label: 'Facebook Story',
      icon: Icons.add_box,
      gradient: [AppColors.facebook, AppColors.facebook],
    ),
    QuickShareApp(
      label: 'Messenger',
      icon: Icons.chat_bubble,
      gradient: [AppColors.messengerStart, AppColors.messengerEnd],
    ),
    QuickShareApp(
      label: 'TikTok',
      icon: Icons.music_note,
      gradient: [AppColors.tiktok, AppColors.tiktok],
    ),
  ];
}
