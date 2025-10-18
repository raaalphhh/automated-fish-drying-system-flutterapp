import 'package:flutter/material.dart';
import 'package:project_app/theme.dart'; // ✅ Import theme.dart

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = true;
  double textSize = 16.0; // Default text size

  bool get isDarkMode => _isDarkMode;

  ThemeData get themeData =>
      _isDarkMode ? NeonDarkTheme.darkTheme : NeonDarkTheme.lightTheme;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void updateTextSize(double newSize) {
    textSize = newSize;
    notifyListeners();
  }
}
