import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/tf_email.dart';

class ForgotPwScreen extends StatefulWidget {
  const ForgotPwScreen({super.key});

  @override
  State<ForgotPwScreen> createState() => _ForgotPwScreenState();
}

class _ForgotPwScreenState extends State<ForgotPwScreen> {
  final emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            content: Text('Kiểm tra Email'),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              SizedBox(height: 50,),
              Text("Nhập Email để đổi Password",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),),
              SizedBox(height: 15.0),
              MyTextField(
                controller: emailController,
                hinText: "Email",
                obscureText: false,
              ),
              SizedBox(height: 15.0,),
              MaterialButton(
                onPressed: passwordReset,
                child: Text('Reset Password',style: TextStyle(color: Colors.white),),
                color: Color(0xFF156081),),
            ],
          ),
        )
    );
  }
}
