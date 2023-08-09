import 'package:flutter/material.dart';

import '../database/auth.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const HomeScreen());
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void onlogout() {
    logoutUser();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Logged out Successfully")),
    );
    Navigator.pushReplacement(context, LoginScreen.route());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: onlogout, icon: const Icon(Icons.logout_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [Text('Welcome Back {user}')],
        ),
      ),
    );
  }
}
