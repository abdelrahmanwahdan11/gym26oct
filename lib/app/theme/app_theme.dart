import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData light() {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: const Color(0xFF6C7CFF),
        secondary: const Color(0xFF7CD4F9),
        surface: const Color(0xFFFFFFFF),
        background: const Color(0xFFF6F7FB),
      ),
      scaffoldBackgroundColor: const Color(0xFFF6F7FB),
      cardTheme: CardTheme(
        color: const Color(0xFFFFFFFF).withOpacity(0.92),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        elevation: 0,
        margin: EdgeInsets.zero,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(base.textTheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Color(0xFF0E1116),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        selectedItemColor: Color(0xFF6C7CFF),
        unselectedItemColor: Color(0x660E1116),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: const Color(0xFFF4F6FF),
        selectedColor: const Color(0xFF6C7CFF).withOpacity(0.18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        labelStyle: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }

  static ThemeData dark() {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: const Color(0xFF8EA0FF),
        secondary: const Color(0xFF7CD4F9),
        surface: const Color(0xFF1B2135),
        background: const Color(0xFF0F1117),
      ),
      scaffoldBackgroundColor: const Color(0xFF0F1117),
      cardTheme: CardTheme(
        color: const Color(0xFF1B2135).withOpacity(0.9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        elevation: 0,
        margin: EdgeInsets.zero,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(base.textTheme.apply(bodyColor: Colors.white)),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        selectedItemColor: Color(0xFF8EA0FF),
        unselectedItemColor: Color(0xB3FFFFFF),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: const Color(0xFF171C2B),
        selectedColor: const Color(0xFF8EA0FF).withOpacity(0.18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        labelStyle: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}
