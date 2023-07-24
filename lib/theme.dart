import 'package:encrypted_notes/constants/AppColors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static getTheme() {
    return ThemeData(
      useMaterial3: true,
       colorScheme: const ColorScheme.light(primary: AppColors.primary)
    );
  }
}
