import 'package:flutter/material.dart';
import 'screens/building_smart_posts_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const QuickShareApp());
}

class QuickShareApp extends StatelessWidget {
  const QuickShareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oriflame Smart Post',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      // Follows the device's light/dark setting automatically and stays
      // in sync if the user flips it while the app is open.
      themeMode: ThemeMode.system,
      home: const BuildingSmartPostsScreen(),
    );
  }
}
