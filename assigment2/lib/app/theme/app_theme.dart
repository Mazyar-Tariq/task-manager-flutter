// App Theme - defines light and dark themes
import 'package:flutter/material.dart'; // For ThemeData

class AppTheme {
  // Base light theme with Material 3 and teal color scheme
  static final _baseLight = ThemeData(
    useMaterial3: true, // Use Material Design 3
    colorSchemeSeed: Colors.teal, // Teal color scheme
    brightness: Brightness.light, // Light brightness
  );

  // Base dark theme with Material 3 and teal color scheme
  static final _baseDark = ThemeData(
    useMaterial3: true, // Use Material Design 3
    colorSchemeSeed: Colors.teal, // Teal color scheme
    brightness: Brightness.dark, // Dark brightness
  );

  // Light theme with rounded card corners
  static ThemeData get light => _baseLight.copyWith(
        cardTheme: const CardThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)), // Rounded corners
          ),
          elevation: 2, // Shadow elevation
        ),
      );

  // Dark theme with rounded card corners
  static ThemeData get dark => _baseDark.copyWith(
        cardTheme: const CardThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)), // Rounded corners
          ),
          elevation: 2, // Shadow elevation
        ),
      );
}

