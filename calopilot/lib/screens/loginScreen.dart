import 'package:calopilot/provider/myState.dart';
import 'package:calopilot/screens/forgotPwScreen.dart';
import 'package:calopilot/screens/siginScreen.dart';
import 'package:calopilot/widgets/tf_email.dart';
import 'package:calopilot/widgets/tf_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/fb_auth.dart';
import '../models/user.dart';
import 'mainScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuthService _auth = FirebaseAuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF156081),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 140),
              Text('Log in',
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                ),),
              SizedBox(height: 40),
              MyTextField(
                controller: emailController,
                hinText: "Email",
                obscureText: false,
              ),
              SizedBox(height: 10,),
              PasswordTextField(
                  controller: passwordController
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPwScreen()),
                      );},
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: 129.0, vertical: 8.0)),
                onPressed: () async {
                  User? user = await _auth.loginUserWithEmailAndPassword(
                      emailController.text, passwordController.text);

                  if (user != null) {
                    Provider.of<MyState>(context,listen:false).user.id = user.uid.toString();
                    ScaffoldMessenger.of(context,).showSnackBar(const SnackBar(
                      content: Text("Đã đăng nhập thành công."),
                    ));

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainScreen()),);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Có lỗi đăng nhập."),
                    ));
                  }
                },
                child: Text(
                  "Log in",
                  style: TextStyle(
                    color: Color(0xFF156081),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                  SizedBox(width: 20,),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                      );},
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
