import 'package:flutter/material.dart';

ThemeData buildThemeData({required Brightness brightness}) {
  final isDark = brightness == Brightness.dark;
  final palette = isDark
      ? const _Palette(
          bgTop: Color(0xFF0F1117),
          bgBottom: Color(0xFF121829),
          surface: Color(0xFF1B2135),
          glass: Color.fromRGBO(27, 33, 53, 0.68),
          textPrimary: Colors.white,
          textSecondary: Color.fromRGBO(255, 255, 255, 0.7),
          border: Color.fromRGBO(255, 255, 255, 0.08),
          accent: Color(0xFF8EA0FF),
          accentAlt: Color(0xFF7CD4F9),
        )
      : const _Palette(
          bgTop: Color(0xFFF6F7FB),
          bgBottom: Color(0xFFEEF2FF),
          surface: Colors.white,
          glass: Color.fromRGBO(255, 255, 255, 0.68),
          textPrimary: Color(0xFF0E1116),
          textSecondary: Color.fromRGBO(14, 17, 22, 0.62),
          border: Color.fromRGBO(14, 17, 22, 0.08),
          accent: Color(0xFF6C7CFF),
          accentAlt: Color(0xFF7CD4F9),
        );

  final colorScheme = ColorScheme(
    brightness: brightness,
    primary: palette.accent,
    onPrimary: Colors.white,
    secondary: palette.accentAlt,
    onSecondary: Colors.white,
    error: const Color(0xFFF87171),
    onError: Colors.white,
    background: palette.bgTop,
    onBackground: palette.textPrimary,
    surface: palette.surface,
    onSurface: palette.textPrimary,
  );

  return ThemeData(
    brightness: brightness,
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: palette.bgTop,
    appBarTheme: AppBarTheme(
      backgroundColor: palette.glass,
      elevation: 0,
      foregroundColor: palette.textPrimary,
    ),
    cardTheme: CardTheme(
      color: palette.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      elevation: 0,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: palette.glass,
      selectedColor: palette.accent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      labelStyle: TextStyle(color: palette.textPrimary),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: palette.glass,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: palette.border),
      ),
    ),
    listTileTheme: ListTileThemeData(
      tileColor: palette.surface.withOpacity(0.8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: palette.accent,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
    ),
    dividerColor: palette.border,
  );
}

class _Palette {
  const _Palette({
    required this.bgTop,
    required this.bgBottom,
    required this.surface,
    required this.glass,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
    required this.accent,
    required this.accentAlt,
  });

  final Color bgTop;
  final Color bgBottom;
  final Color surface;
  final Color glass;
  final Color textPrimary;
  final Color textSecondary;
  final Color border;
  final Color accent;
  final Color accentAlt;
}
