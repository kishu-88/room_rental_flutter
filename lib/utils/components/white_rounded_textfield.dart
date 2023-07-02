import 'package:flutter/material.dart';

class WhiteRoundedTextfield extends StatelessWidget {
  final TextEditingController controller;

  const WhiteRoundedTextfield({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          focusColor: Colors.white,
          hoverColor: Colors.white,
          filled: true,
          fillColor: const Color.fromARGB(255, 255, 255, 255),// Set the background color here
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(90.0),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(90.0),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
