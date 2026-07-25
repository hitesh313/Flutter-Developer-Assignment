import 'package:flutter/material.dart';
import '../models/share_models.dart';

/// Hardcoded data for the demo — the brief explicitly recommends
/// skipping backend/API work and demoing with static values.
class DemoData {
  DemoData._();

  static const SharePost post = SharePost(
    authorName: 'Maya Chen',
    authorColor: Color(0xFFFFB74D),
    caption:
        'Golden hour on the coastline never gets old \u2600\ufe0f Chasing '
        'light and good company today.',
    mediaColor: Color(0xFF6C5CE7),
    timeAgo: '2h ago',
  );

  static const List<ShareContact> contacts = [
    ShareContact(id: 'c1', name: 'Aarav', avatarColor: Color(0xFFFF7675), isOnline: true),
    ShareContact(id: 'c2', name: 'Priya', avatarColor: Color(0xFF00B894), isOnline: true),
    ShareContact(id: 'c3', name: 'Dev', avatarColor: Color(0xFF0984E3)),
    ShareContact(id: 'c4', name: 'Isha', avatarColor: Color(0xFFFDCB6E), isOnline: true),
    ShareContact(id: 'c5', name: 'Rohan', avatarColor: Color(0xFFA29BFE)),
    ShareContact(id: 'c6', name: 'Neha', avatarColor: Color(0xFFFF6584)),
  ];

  static const List<ShareDestination> destinations = [
    ShareDestination(id: 'whatsapp', label: 'WhatsApp', icon: Icons.chat, color: Color(0xFF25D366)),
    ShareDestination(id: 'instagram', label: 'Instagram', icon: Icons.camera_alt, color: Color(0xFFE1306C)),
    ShareDestination(id: 'twitter', label: 'X', icon: Icons.tag, color: Color(0xFF1A1A2E)),
    ShareDestination(id: 'facebook', label: 'Facebook', icon: Icons.facebook, color: Color(0xFF1877F2)),
    ShareDestination(id: 'email', label: 'Email', icon: Icons.email, color: Color(0xFF6C5CE7)),
    ShareDestination(id: 'more', label: 'More', icon: Icons.more_horiz, color: Color(0xFF8A8A9E)),
  ];

  static const String shareLink = 'https://quickshare.app/p/8f3a21';
}
