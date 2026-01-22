import 'package:flutter/material.dart';
import 'package:study_path/core/themes/text_theme.dart';

class AppTheme {
  static ThemeData getApplicationLightTheme() {
    return ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        // elevatedButtonTheme: AppElevatedButtonTheme.elevatedButtonLightTheme
         );
  }

  static ThemeData getApplicationDarkTheme() {
    return ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        // elevatedButtonTheme: AppElevatedButtonTheme.elevatedButtonDarkTheme
    );
  }
}
