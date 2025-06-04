// core/theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  // Define color constants
  static const Color primaryColor = Color(0xFF7488E4);
  static const Color backgroundColor = Colors.white;
  static const Color darkGradientColor = Colors.black;
  static const Color errorColor = Colors.red;
  static const Color disabledColor = Colors.grey;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        surface: backgroundColor,
        error: errorColor,
        onPrimary: Colors.white,
        onSurface: Colors.black,
        onSecondary: Colors.white70,
      ),
      scaffoldBackgroundColor: backgroundColor,
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          letterSpacing: 2,
          color: Color(0xFF4D4F50),
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4D4F50),
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Color(0xFF4D4F50),
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: Color(0xFF4D4F50),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: backgroundColor,
        elevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: backgroundColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
      ),
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.zero,
        minLeadingWidth: 16,
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
      splashFactory: NoSplash.splashFactory,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          backgroundColor: Color(0xFF7488E4),
          foregroundColor: Color(0xFFFFFCFC),
          textStyle: TextStyle(fontSize: 16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFFF5F5F5),
        labelStyle: TextStyle(color: Color(0xFF363636)),
        floatingLabelStyle: TextStyle(color: Color(0xFF7488E4)),
        hintStyle: TextStyle(color: Color(0xFF363636)),
        errorStyle: TextStyle(color: errorColor),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: primaryColor, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: primaryColor, width: 1.5),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return lightTheme;
  }

  static ThemeData getTheme({required bool isDarkMode}) {
    return isDarkMode ? darkTheme : lightTheme;
  }
}
