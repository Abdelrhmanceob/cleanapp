import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryGold = Color(0xFFE6C21A);
  static const Color primaryDark = Color(0xFF705D00);
  static const Color backgroundCream = Color(0xFFF6F4EE);
  static const Color surfaceWhite = Color(0xFFFFFEFA);
  static const Color borderSubtle = Color(0xFFD7D0BD);
  static const Color textDark = Color(0xFF1C1B1B);
  static const Color textMuted = Color(0xFF635E4F);
  static const Color successGreen = Color(0xFF2D8E5B);
  static const Color errorRed = Color(0xFFBA1A1A);
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
      scaffoldBackgroundColor: backgroundCream,
      textTheme: GoogleFonts.outfitTextTheme().copyWith(
        displayLarge: GoogleFonts.playfairDisplay(
          fontSize: 48,
          fontWeight: FontWeight.w700,
          color: textDark,
          letterSpacing: -0.96,
          height: 56 / 48,
        ),
        headlineLarge: GoogleFonts.playfairDisplay(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: textDark,
          height: 40 / 32,
        ),
        headlineMedium: GoogleFonts.playfairDisplay(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: textDark,
          height: 32 / 24,
        ),
        titleLarge: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        bodyLarge: GoogleFonts.outfit(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: textDark,
          height: 28 / 18,
        ),
        bodyMedium: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: textDark,
          height: 24 / 16,
        ),
        labelLarge: GoogleFonts.outfit(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: textDark,
          letterSpacing: 0.7,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGold,
          foregroundColor: textDark,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w600),
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