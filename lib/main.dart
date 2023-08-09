import 'package:events/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Events App ',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: const LoginScreen());
  }
}
