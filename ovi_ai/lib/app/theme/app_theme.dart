import 'package:flutter/material.dart';

abstract final class OviColors {
  static const background = Color(0xFF07090F);
  static const surface = Color(0xFF0E121B);
  static const surfaceRaised = Color(0xFF141A25);
  static const glass = Color(0x261E293B);
  static const glassStrong = Color(0x4A1E293B);
  static const border = Color(0x2E8B9BB2);
  static const primary = Color(0xFFB9A6FF);
  static const primaryBright = Color(0xFFD7CDFF);
  static const cyan = Color(0xFF7DE3E0);
  static const peach = Color(0xFFFFB58D);
  static const text = Color(0xFFF4F2FA);
  static const textMuted = Color(0xFF9EA5B5);
  static const success = Color(0xFF7EE3B1);
  static const warning = Color(0xFFFFC27D);
}

abstract final class OviTheme {
  static ThemeData dark() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: OviColors.primary,
      brightness: Brightness.dark,
      surface: OviColors.surface,
    ).copyWith(
      primary: OviColors.primary,
      onPrimary: OviColors.background,
      secondary: OviColors.cyan,
      onSecondary: OviColors.background,
      surface: OviColors.surface,
      onSurface: OviColors.text,
      outline: OviColors.border,
    );

    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: OviColors.background,
      useMaterial3: true,
      fontFamily: 'Inter',
      visualDensity: VisualDensity.adaptivePlatformDensity,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.windows: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.linux: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      textTheme: const TextTheme(
        displaySmall: TextStyle(
          color: OviColors.text,
          fontSize: 36,
          fontWeight: FontWeight.w700,
          height: 1.05,
          letterSpacing: -1.2,
        ),
        headlineMedium: TextStyle(
          color: OviColors.text,
          fontSize: 26,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.6,
        ),
        titleLarge: TextStyle(
          color: OviColors.text,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: TextStyle(
          color: OviColors.text,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(color: OviColors.text, fontSize: 16, height: 1.45),
        bodyMedium: TextStyle(
          color: OviColors.textMuted,
          fontSize: 14,
          height: 1.45,
        ),
        labelLarge: TextStyle(
          color: OviColors.text,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: OviColors.text,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: OviColors.surface.withValues(alpha: 0.94),
        indicatorColor: OviColors.primary.withValues(alpha: 0.18),
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: Colors.transparent,
        indicatorColor: OviColors.primary.withValues(alpha: 0.18),
        selectedIconTheme: const IconThemeData(color: OviColors.primaryBright),
        unselectedIconTheme: const IconThemeData(color: OviColors.textMuted),
        selectedLabelTextStyle: const TextStyle(
          color: OviColors.primaryBright,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelTextStyle: const TextStyle(
          color: OviColors.textMuted,
          fontWeight: FontWeight.w500,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: OviColors.border,
        space: 1,
        thickness: 1,
      ),
    );
  }
}
