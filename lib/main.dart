import 'dart:io';

import 'package:events/check_sessions.dart';
import 'package:events/theme/app_theme.dart';
import 'package:events/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? preferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();

  HttpOverrides.global = MyHttpOverrides();
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
        theme: AppTheme.theme.copyWith(
            textTheme: Theme.of(context)
                .textTheme
                .apply(bodyColor: Pallete.blackColor)),
        home: const CheckSessions());
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
