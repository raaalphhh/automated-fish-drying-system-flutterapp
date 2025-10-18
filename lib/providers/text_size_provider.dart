import 'package:flutter/material.dart';

class TextSizeProvider with ChangeNotifier {
  double _textSize = 16.0; // Default text size

  double get textSize => _textSize;

  void setTextSize(double newSize) {
    _textSize = newSize;
    notifyListeners();
  }
}
