import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final BuildContext context;
  final IconButton? icon;
  final TextInputType keyboardType;
  final String? Function(String?)? validation;
  final bool obsecured;

  const InputFieldWidget({
    super.key,
    this.hintText = '',
    required this.controller,
    required this.context,
    required this.validation,
    this.keyboardType = TextInputType.text,
    this.icon,
    this.obsecured = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: TextFormField(
        obscureText: obsecured,
        keyboardType: keyboardType,
        controller: controller,
        validator: validation,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            hintText: hintText,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50))),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            suffixIcon: icon),
        style: GoogleFonts.laila(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF363636),
        ),
      ),
    );
  }
}
