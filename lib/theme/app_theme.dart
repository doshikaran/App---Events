import 'package:events/theme/theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundcolor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Pallete.backgroundcolor,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Pallete.purpleColor,
    ),
  );
}
