import 'package:flutter/material.dart';

class AppTheme {
  // Core colors
  static const Color primaryColor = Color(0xFF6C63FF); // Lavender-indigo
  static const Color secondaryColor = Color(0xFFFF89BB); // Rose pink
  static const Color backgroundColor = Color(0xFFF5F7FA); // Soft misty white
  static const Color textColor = Color(0xFF3A3D56); // Deep gray-blue
  static const Color accentColor = Color(0xFF06D6A0); // Green for high mood
  static const Color neutralColor = Color(0xFFFFD166); // Amber for neutral
  static const Color cardColor = Colors.white;

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    canvasColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      surface: Colors.white,
      onSurface: textColor,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
          fontSize: 32, fontWeight: FontWeight.bold, color: textColor),
      headlineMedium: TextStyle(
          fontSize: 24, fontWeight: FontWeight.w600, color: textColor),
      titleLarge: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w500, color: textColor),
      bodyLarge: TextStyle(fontSize: 16, color: textColor),
      bodyMedium: TextStyle(fontSize: 14, color: textColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFDCE2F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: accentColor, // Green for high mood
      inactiveTrackColor: neutralColor, // Amber for neutral
      thumbColor: primaryColor,
      overlayColor: primaryColor.withAlpha(41), // 0x29 = 41 in decimal
      trackHeight: 6.0,
    ),
  );
}
