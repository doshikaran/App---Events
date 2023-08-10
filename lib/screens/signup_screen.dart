import 'package:events/database/auth.dart';
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

// sign up
  void onsignUp() {
    createUser(_nameController.text, _emailController.text,
            _passwordController.text)
        .then((value) {
      if (value == "User created successfully") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Account created successfully, Please Login")),
        );
        Navigator.push(context, LoginScreen.route());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(value)),
        );
      }
    });
  }

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
                    color: Pallete.blackColor),
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
                  onTap: onsignUp,
                  label: 'Sign Up',
                  backgroundColor: Pallete.purpleColor,
                  textColor: Colors.white),
              const SizedBox(height: 25),
              RichText(
                  text: TextSpan(
                      text: "Already have an account?",
                      style: const TextStyle(
                          fontSize: 14, color: Pallete.blackColor),
                      children: [
                    TextSpan(
                        text: ' Please Log in',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 105, 104, 104),
                            fontSize: 14),
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
