// Theme Controller - manages light/dark theme switching
import 'package:flutter/material.dart'; // For ThemeMode
import 'package:get/get.dart'; // GetX for state management
import 'package:get_storage/get_storage.dart'; // Local storage

class ThemeController extends GetxController {
  static const _key = 'themeMode'; // Key for storing theme preference
  final _box = GetStorage(); // Storage instance
  ThemeMode themeMode = ThemeMode.system; // Default to system theme

  @override
  void onInit() {
    super.onInit();
    // Load saved theme from storage
    final stored = _box.read<String?>(_key);
    if (stored != null) {
      themeMode = stored == 'dark' ? ThemeMode.dark : ThemeMode.light;
    }
  }

  // Toggle between light and dark theme
  void toggleTheme() {
    // Check current theme and switch to opposite
    final isDark = themeMode == ThemeMode.dark;
    themeMode = isDark ? ThemeMode.light : ThemeMode.dark;

    // Save the new theme to storage
    _box.write(_key, themeMode == ThemeMode.dark ? 'dark' : 'light');

    // Notify listeners to update UI
    update(['theme', 'rootTheme']);
  }
}

