import 'package:encrypted_notes/extensions/ColorExtension.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static getTheme() {
    final primaryColor = "#2D9CDB".toColor();
    return ThemeData(
      useMaterial3: true,
       colorScheme: ColorScheme.light(primary: primaryColor)
    );
  }
}
