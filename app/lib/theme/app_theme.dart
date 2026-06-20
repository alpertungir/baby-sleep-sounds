import 'package:flutter/material.dart';

class AppTheme {
  static const _seed = Color(0xFF7B9ACC);

  static ThemeData dark() {
    final scheme = ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: const Color(0xFF0F1419),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.55),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: scheme.primary,
        inactiveTrackColor: scheme.primary.withValues(alpha: 0.25),
        thumbColor: scheme.primary,
      ),
    );
  }
}
