import 'package:flutter/material.dart';

/// One AI-generated "Smart Post" — a full-bleed reel-style card the user
/// can quick-share straight to social apps.
class SmartPost {
  final String creatorInitial;
  final Color creatorAvatarColor;
  final String communityLine;

  /// Placeholder gradient standing in for the product photo (no real
  /// image asset exists for this demo — see README).
  final List<Color> backgroundGradient;
  final IconData heroIcon;

  final IconData productIcon;
  final String productName;
  final String priceLabel;
  final String discountLabel;
  final bool trending;

  final String songTitle;
  final String songArtist;

  final String caption;
  final String hashtags;
  final String referralCode;
  final String referralLink;

  SmartPost({
    required this.creatorInitial,
    required this.creatorAvatarColor,
    required this.communityLine,
    required this.backgroundGradient,
    required this.heroIcon,
    required this.productIcon,
    required this.productName,
    required this.priceLabel,
    required this.discountLabel,
    required this.trending,
    required this.songTitle,
    required this.songArtist,
    required this.caption,
    required this.hashtags,
    required this.referralCode,
    required this.referralLink,
  });
}

/// A single destination in the "Quick share to" row.
class QuickShareApp {
  final String label;
  final IconData icon;
  final List<Color> gradient;

  const QuickShareApp({
    required this.label,
    required this.icon,
    required this.gradient,
  });
}
