import 'package:flutter/material.dart';

class ThemeManager {
  static final Color black = const Color(0xFF1E1E1E);
  static final Color white = const Color(0xFFF5F5F5);
  static final Color blue = const Color(0xFF4A6FA5);
  static final Color turquoise = const Color(0xFF4FB0A6);
  static final Color green = const Color(0xFF6FAF85);

  static ThemeData getTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      primaryColor: blue,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: blue,
        primary: blue,
        secondary: turquoise,
        surface: black,
        onPrimary: white,
        onSecondary: white,
        onSurface: white,
        tertiary: green,
        onTertiary: white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: white,
        elevation: 0,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Color(0xFFF5F5F5)),
        bodyLarge: TextStyle(color: Color(0xFFF5F5F5)),
        titleMedium: TextStyle(color: Color(0xFFF5F5F5)),
      ),
      iconTheme: IconThemeData(color: white),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: blue,
          foregroundColor: white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: black.withAlpha((0.3 * 255).round()),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: white.withAlpha((0.2 * 255).round())),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: blue),
        ),
        labelStyle: TextStyle(color: white.withAlpha((0.7 * 255).round())),
      ),
      cardColor: black,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: turquoise,
        foregroundColor: white,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: green),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: green),
      ),
      dividerColor: white.withAlpha((0.2 * 255).round()),
    );
  }
}
