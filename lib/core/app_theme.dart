import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Define Cosmic Editorial colors from Stitch specifications
  static const Color background = Color(0xFF1c1c24);
  static const Color surface = Color(0xFF1c1c24);
  static const Color surfaceContainerLow = Color(0xFF131319);
  static const Color surfaceContainer = Color(0xFF191920);
  static const Color surfaceContainerHigh = Color(0xFF1f1f27);
  static const Color surfaceContainerHighest = Color(0xFF25252e);
  static const Color surfaceVariant = Color(0xFF25252e);
  static const Color primary = Color(0xFFa68cff);
  static const Color primaryContainer = Color(0xFF7c4dff);
  static const Color secondary = Color(0xFFff8c4d);
  static const Color secondaryContainer = Color(0xFFff8c4d);
  static const Color tertiary = Color(0xFFb5ffc2);
  static const Color tertiaryContainer = Color(0xFF3fff8b);
  static const Color onPrimary = Color(0xFF25006b);
  static const Color onTertiary = Color(0xFF006731);
  static const Color outlineVariant = Color(
    0xFF474751,
  ); // 15% opacity when used
  static const Color onSurface = Color(0xFFe6e4f1);
  static const Color error = Color(0xFFff6b6b);

  // Gradient for Primary CTA
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryContainer],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    transform: GradientRotation(2.35619), // ~135 degrees in radians
  );

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.dark(
        background: background,
        surface: surface,
        primary: primary,
        primaryContainer: primaryContainer,
        tertiary: tertiary,
        tertiaryContainer: tertiaryContainer,
        onSurface: onSurface,
        onPrimary: onPrimary,
        onTertiary: onTertiary,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.spaceGrotesk(
          fontSize: 57,
          fontWeight: FontWeight.bold,
          color: onSurface,
        ),
        displayMedium: GoogleFonts.spaceGrotesk(
          fontSize: 45,
          fontWeight: FontWeight.bold,
          color: onSurface,
        ),
        displaySmall: GoogleFonts.spaceGrotesk(
          fontSize: 36, // 2.25rem
          fontWeight: FontWeight.bold,
          color: onSurface,
        ),
        headlineLarge: GoogleFonts.spaceGrotesk(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: onSurface,
        ),
        bodyLarge: GoogleFonts.manrope(fontSize: 16, color: onSurface),
        bodyMedium: GoogleFonts.manrope(fontSize: 14, color: onSurface),
        bodySmall: GoogleFonts.manrope(
          fontSize: 12, // 0.75rem
          color: onSurface,
        ),
        labelSmall: GoogleFonts.manrope(fontSize: 11, color: onSurface),
      ),
      useMaterial3: true,
    );
  }
}
