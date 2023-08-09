import 'package:events/theme/theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme = ThemeData.dark().copyWith(
    textTheme: TextTheme(),
    scaffoldBackgroundColor: Pallete.backgroundcolor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Pallete.backgroundcolor,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Pallete.blueColor,
    ),
  );
}
