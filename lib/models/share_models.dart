import 'package:flutter/material.dart';

/// A person the user can quickly share content with directly.
class ShareContact {
  final String id;
  final String name;
  final Color avatarColor;
  final bool isOnline;

  const ShareContact({
    required this.id,
    required this.name,
    required this.avatarColor,
    this.isOnline = false,
  });
}

/// An external destination (app / action) the post can be shared to,
/// e.g. WhatsApp, Instagram, Copy Link.
class ShareDestination {
  final String id;
  final String label;
  final IconData icon;
  final Color color;

  const ShareDestination({
    required this.id,
    required this.label,
    required this.icon,
    required this.color,
  });
}

/// The piece of content being shared — shown in the preview card.
class SharePost {
  final String authorName;
  final Color authorColor;
  final String caption;
  final Color mediaColor;
  final String timeAgo;

  const SharePost({
    required this.authorName,
    required this.authorColor,
    required this.caption,
    required this.mediaColor,
    required this.timeAgo,
  });
}
