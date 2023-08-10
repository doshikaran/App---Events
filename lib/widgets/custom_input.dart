import 'package:events/theme/pallete.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintext;
  final IconData icon;
  final String label;
  final bool? obsecureText;
  final VoidCallback? onTap;
  const CustomInput(
      {super.key,
      required this.controller,
      required this.hintext,
      required this.icon,
      required this.label,
      this.obsecureText,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      obscureText: obsecureText ?? false,
      decoration: InputDecoration(
          focusColor: Pallete.greyColor,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Pallete.greyColor, width: 2)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Pallete.greyColor)),
          contentPadding: const EdgeInsets.all(20),
          prefixIcon: Icon(icon, color: Pallete.blackColor),
          labelText: label,
          labelStyle: const TextStyle(
              fontSize: 14, letterSpacing: 2, color: Pallete.blackColor),
          hintText: hintext,
          hintStyle: const TextStyle(
            fontSize: 14,
            letterSpacing: 2,
          )),
    );
  }
}
