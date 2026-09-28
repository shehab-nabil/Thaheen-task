import 'package:flutter/material.dart';

class AppTextStyles {
  const AppTextStyles._();

  static const String heading = 'ReadexPro';
  static const String body = 'IBMPlexSansArabic';

  // ReadexPro ships as a single variable font (weight axis). fontWeight
  // alone can be ignored by some renderers for variable fonts, so the axis
  // is also set explicitly via fontVariations as a safety net.
  static const List<FontVariation> _semiBoldVariation = [
    FontVariation('wght', 600),
  ];

  static TextTheme textTheme(Color primaryText, Color secondaryText) {
    return TextTheme(
      headlineMedium: TextStyle(
        fontFamily: heading,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        fontVariations: _semiBoldVariation,
        color: primaryText,
      ),
      headlineSmall: TextStyle(
        fontFamily: heading,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontVariations: _semiBoldVariation,
        color: primaryText,
      ),
      titleLarge: TextStyle(
        fontFamily: heading,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontVariations: _semiBoldVariation,
        color: primaryText,
      ),
      titleMedium: TextStyle(
        fontFamily: body,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: primaryText,
      ),
      bodyLarge: TextStyle(
        fontFamily: body,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: primaryText,
      ),
      bodyMedium: TextStyle(
        fontFamily: body,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: primaryText,
      ),
      bodySmall: TextStyle(
        fontFamily: body,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: secondaryText,
      ),
      labelLarge: TextStyle(
        fontFamily: body,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: primaryText,
      ),
      labelMedium: TextStyle(
        fontFamily: body,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: secondaryText,
      ),
    );
  }
}
