import 'package:events/screens/login_screen.dart';
import 'package:events/widgets/custom_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../theme/pallete.dart';
import '../widgets/custom_input.dart';

class SignupScreen extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const SignupScreen());
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome, Please Sign Up',
                style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 5,
                    fontWeight: FontWeight.w600,
                    color: Pallete.whiteColor),
              ),
              const SizedBox(height: 25),
              CustomInput(
                controller: _nameController,
                icon: Icons.person,
                label: 'Name',
                hintext: 'Enter you Name',
              ),
              const SizedBox(height: 25),
              CustomInput(
                controller: _emailController,
                icon: Icons.email,
                label: 'Email',
                hintext: 'Enter your Email',
              ),
              const SizedBox(height: 25),
              CustomInput(
                  obsecureText: true,
                  controller: _passwordController,
                  icon: Icons.lock,
                  label: 'Password',
                  hintext: 'Enter your Password'),
              const SizedBox(height: 25),
              CustomButton(
                  onTap: () {},
                  label: 'Login',
                  backgroundColor: Pallete.whiteColor,
                  textColor: Colors.black),
              const SizedBox(height: 25),
              RichText(
                  text: TextSpan(
                      text: "Already have an account?",
                      style: const TextStyle(fontSize: 14),
                      children: [
                    TextSpan(
                        text: ' Please Log in',
                        style: const TextStyle(
                            color: Pallete.greyColor, fontSize: 14),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(context, LoginScreen.route());
                          })
                  ]))
            ],
          ),
        ),
      )),
    );
  }
}
