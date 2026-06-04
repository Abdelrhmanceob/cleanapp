import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Dr Cleaner / stitch design tokens (DESIGN.md).
class AppTheme {
  static const Color primaryGold = Color(0xFFFCD000);
  static const Color primaryDark = Color(0xFF715C00);
  static const Color backgroundCream = Color(0xFFFFF8EF);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color borderSubtle = Color(0xFFD0C6AB);
  static const Color textDark = Color(0xFF201B0B);
  static const Color textMuted = Color(0xFF4D4632);
  static const Color successGreen = Color(0xFF2D8E5B);
  static const Color errorRed = Color(0xFFBA1A1A);
  static const Color embedBackground = Color(0xFF111214);
  static const Color darkBackground = Color(0xFF121314);
  static const Color darkCard = Color(0xFF252420);
  static const Color darkSurface = Color(0xFF1E1D1A);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: primaryGold,
        onPrimary: textDark,
        secondary: textMuted,
        onSecondary: Colors.white,
        surface: surfaceWhite,
        onSurface: textDark,
        error: errorRed,
        outline: borderSubtle,
      ),
      scaffoldBackgroundColor: embedBackground,
      fontFamily: GoogleFonts.cairo().fontFamily,
      textTheme: GoogleFonts.cairoTextTheme().apply(
        bodyColor: textDark,
        displayColor: textDark,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGold,
          foregroundColor: textDark,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      cardTheme: CardThemeData(
        color: surfaceWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: borderSubtle, width: 1),
        ),
      ),
    );
  }
}
