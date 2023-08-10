import 'package:events/database/auth.dart';
import 'package:events/screens/home_screen.dart';
import 'package:events/screens/login_screen.dart';
import 'package:flutter/material.dart';

class CheckSessions extends StatefulWidget {
  const CheckSessions({super.key});

  @override
  State<CheckSessions> createState() => _CheckSessionsState();
}

class _CheckSessionsState extends State<CheckSessions> {
  @override
  void initState() {
    checkUserSession().then((value) {
      if (value == "userSession") {
        Navigator.pushReplacement(context, HomeScreen.route());
      } else {
        Navigator.pushReplacement(context, LoginScreen.route());
      }
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [Text("Please wait")],
        ),
      ),
    );
  }
}
