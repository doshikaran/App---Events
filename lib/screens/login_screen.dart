import 'package:events/database/auth.dart';
import 'package:events/screens/home_screen.dart';
import 'package:events/screens/signup_screen.dart';
import 'package:events/theme/pallete.dart';
import 'package:events/widgets/custom_button.dart';
import 'package:events/widgets/custom_input.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const LoginScreen());
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void onlogin() {
    loginUser(
      _emailController.text,
      _passwordController.text,
    ).then((value) {
      if (value == 'User logged successfully') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login Successful")),
        );
        Navigator.push(context, HomeScreen.route());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login Failed')),
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
                'Login',
                style: TextStyle(
                    fontSize: 30,
                    letterSpacing: 5,
                    fontWeight: FontWeight.w600,
                    color: Pallete.blackColor),
              ),
              const SizedBox(height: 25),
              CustomInput(
                obsecureText: false,
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Pallete.whiteColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              CustomButton(
                  onTap: onlogin,
                  label: 'Login',
                  backgroundColor: Pallete.purpleColor,
                  textColor: Colors.white),
              const SizedBox(height: 25),
              RichText(
                  text: TextSpan(
                      text: "Do not have an account?",
                      style: const TextStyle(
                          fontSize: 14, color: Pallete.blackColor),
                      children: [
                    TextSpan(
                        text: ' Sign up',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 105, 104, 104),
                            fontSize: 14),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(context, SignupScreen.route());
                          })
                  ]))
            ],
          ),
        ),
      )),
    );
  }
}
