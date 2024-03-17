import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hinText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hinText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hinText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
        )
      ),
      style: TextStyle(color: Colors.grey, fontSize: 25),
    );
  }
}
