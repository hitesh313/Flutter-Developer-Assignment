import 'package:flutter/material.dart';
import 'screens/quick_share_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const QuickShareApp());
}

class QuickShareApp extends StatelessWidget {
  const QuickShareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quick Share',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const QuickShareScreen(),
    );
  }
}
