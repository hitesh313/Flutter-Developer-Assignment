import 'package:flutter/material.dart';

/// Design tokens pulled from the Figma "Smart Posts Feature" file.
class AppColors {
  AppColors._();

  static const Color black = Color(0xFF1B1B1B);
  static const Color white = Colors.white;
  static const Color textSecondary = Color(0xFF8C8C93);
  static const Color divider = Color(0xFFE9E9EE);

  // Brand accents seen throughout the design.
  static const Color aiGreen = Color(0xFF33C481);
  static const Color saleGreen = Color(0xFF17C77E);
  static const Color readyPinkStart = Color(0xFFFF5FA0);
  static const Color readyPinkEnd = Color(0xFFB35FF0);

  // Social icon brand colors for the "Quick share to" row.
  static const Color facebook = Color(0xFF1877F2);
  static const Color messengerStart = Color(0xFF00B2FF);
  static const Color messengerEnd = Color(0xFFB620E0);
  static const Color instagramStart = Color(0xFFFEDA75);
  static const Color instagramMid = Color(0xFFD62976);
  static const Color instagramEnd = Color(0xFF962FBF);
  static const Color tiktok = Color(0xFF010101);

  // Dark-mode variant of the "Building Smart Posts" loader.
  static const Color darkBg = Color(0xFF141414);
  static const Color darkTextSecondary = Color(0xFF8C8C93);
}

/// Neutral chrome colors that flip between light and dark automatically
/// with the device's system setting. Brand accents (green, pink, social
/// icon colors) and anything drawn on top of the post photo stay fixed
/// in both modes — see the README for why.
class AppPalette {
  final Color scaffoldBg;
  final Color surface;
  final Color textPrimary;
  final Color textSecondary;
  final Color divider;
  final Color navIconCircle;
  final Color navIconGlyph;

  const AppPalette({
    required this.scaffoldBg,
    required this.surface,
    required this.textPrimary,
    required this.textSecondary,
    required this.divider,
    required this.navIconCircle,
    required this.navIconGlyph,
  });

  static const light = AppPalette(
    scaffoldBg: Colors.white,
    surface: Colors.white,
    textPrimary: AppColors.black,
    textSecondary: AppColors.textSecondary,
    divider: AppColors.divider,
    navIconCircle: AppColors.black,
    navIconGlyph: Colors.white,
  );

  static const dark = AppPalette(
    scaffoldBg: AppColors.darkBg,
    surface: Color(0xFF1F1F22),
    textPrimary: Colors.white,
    textSecondary: AppColors.darkTextSecondary,
    divider: Color(0xFF2C2C30),
    navIconCircle: Colors.white,
    navIconGlyph: AppColors.darkBg,
  );
}

/// Reads the palette matching the current system brightness. `MaterialApp`
/// is set to `themeMode: ThemeMode.system`, so `Theme.of(context)` already
/// reflects the device's live light/dark setting — this just maps that to
/// our own token set.
AppPalette paletteOf(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark ? AppPalette.dark : AppPalette.light;
}

class AppSpacing {
  AppSpacing._();
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
}

class AppText {
  AppText._();

  static const TextStyle brand = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    letterSpacing: 2.5,
    color: AppColors.black,
  );

  static const TextStyle brandSub = TextStyle(
    fontSize: 7,
    fontWeight: FontWeight.w500,
    letterSpacing: 2,
    color: AppColors.textSecondary,
  );

  static const TextStyle navTab = TextStyle(
    fontSize: 12.5,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  static const TextStyle navTabActive = TextStyle(
    fontSize: 12.5,
    fontWeight: FontWeight.w700,
    color: AppColors.aiGreen,
  );

  static const TextStyle nameLabel = TextStyle(
    fontSize: 12.5,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const TextStyle communityLine = TextStyle(
    fontSize: 11.5,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static const TextStyle captionLabel = TextStyle(
    fontSize: 10.5,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.6,
    color: Colors.white70,
  );

  static const TextStyle editCaptionLink = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const TextStyle body = TextStyle(
    fontSize: 12.5,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: Colors.white,
  );

  static const TextStyle referral = TextStyle(
    fontSize: 12,
    fontStyle: FontStyle.italic,
    color: Colors.white70,
    height: 1.35,
  );

  static const TextStyle productTitle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );

  static const TextStyle productSub = TextStyle(
    fontSize: 11.5,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );
}

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.white,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.aiGreen,
        primary: AppColors.aiGreen,
      ),
      fontFamily: 'Roboto',
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.aiGreen,
        primary: AppColors.aiGreen,
        brightness: Brightness.dark,
      ),
      fontFamily: 'Roboto',
    );
  }
}
