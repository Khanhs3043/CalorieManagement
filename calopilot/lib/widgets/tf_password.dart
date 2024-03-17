import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget{
  PasswordTextField({Key? key, required this.controller, }) : super(key: key);
  final TextEditingController controller;

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  var obscureText = true;
  @override
  Widget build(BuildContext context) {

    return TextField(
      controller: widget.controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          hintText: 'Password',
          hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 2.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 2.0),
          ),
          suffixIcon: GestureDetector(
              onTap: (){
                setState(() {
                  obscureText = !obscureText;
                });
              },
              child: obscureText
                  ? const Icon(Icons.visibility_off, color: Colors.grey,)
                  : const Icon(Icons.visibility, color: Colors.grey,)
          )
      ),
    style: TextStyle(color: Colors.grey, fontSize: 25),
    );
  }
}