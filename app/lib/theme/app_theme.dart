import 'package:flutter/material.dart';

class AppTheme {
  static const _background = Color(0xFF2D1B69);
  static const _surface = Color(0xFF3F2B7A);

  static ThemeData dark() {
    const scheme = ColorScheme.dark(
      primary: Color(0xFFFFB74D),
      secondary: Color(0xFF81C784),
      tertiary: Color(0xFF64B5F6),
      surface: _surface,
      onPrimary: Color(0xFF3E2723),
      onSurface: Color(0xFFFFF8E1),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: _background,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: _background,
        foregroundColor: Color(0xFFFFF8E1),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: Color(0xFFFFF8E1),
        textColor: Color(0xFFFFF8E1),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
      dividerTheme: DividerThemeData(
        color: Colors.white.withValues(alpha: 0.12),
        space: 1,
        thickness: 1,
      ),
      cardTheme: CardThemeData(
        color: _surface,
        elevation: 4,
        shadowColor: Colors.black45,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: scheme.primary,
        inactiveTrackColor: scheme.primary.withValues(alpha: 0.3),
        thumbColor: scheme.primary,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: scheme.secondary,
        contentTextStyle: const TextStyle(color: Colors.white),
      ),
    );
  }
}
