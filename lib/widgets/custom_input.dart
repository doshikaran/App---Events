import 'package:events/theme/pallete.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintext;
  final IconData icon;
  final String label;
  final bool? obsecureText;
  const CustomInput(
      {super.key,
      required this.controller,
      required this.hintext,
      required this.icon,
      required this.label,
      this.obsecureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obsecureText ?? false,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white, width: 2)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 174, 173, 173),
              )),
          contentPadding: const EdgeInsets.all(20),
          prefixIcon: Icon(icon, color: Colors.white),
          labelText: label,
          labelStyle: const TextStyle(
              fontSize: 14, letterSpacing: 2, color: Pallete.greyColor),
          hintText: hintext,
          hintStyle: const TextStyle(
            fontSize: 14,
            letterSpacing: 2,
          )),
    );
  }
}
