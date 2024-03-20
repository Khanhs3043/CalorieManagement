import 'package:calopilot/models/user.dart';
import 'package:calopilot/screens/loginScreen.dart';
import 'package:provider/provider.dart';
import '../provider/myState.dart';
import '../services/dbHelper.dart';
import '../widgets/tf_confirm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/fb_auth.dart';
import '../widgets/tf_email.dart';
import '../widgets/tf_password.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  FirebaseAuthService _auth = FirebaseAuthService();
  final fullnameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80),
              Text('Sign up',
                style: TextStyle(
                    fontSize: 40,
                    color: Color(0xFF156081),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Toboto'
                ),),
              SizedBox(height: 20),
              MyTextField(
                controller: emailController,
                hinText: "Email",
                obscureText: false,
              ),
              SizedBox(height: 10,),
              MyTextField(
                controller: fullnameController,
                hinText: "Full name",
                obscureText: false,
              ),
              SizedBox(height: 10,),
              MyTextField(
                controller: usernameController,
                hinText: "Username",
                obscureText: false,
              ),
              SizedBox(height: 10,),
              PasswordTextField(
                  controller: passwordController
              ),
              SizedBox(height: 10,),
              ConfirmTextField(
                  controller: confirmController),
              SizedBox(height: 60),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: 119.5, vertical: 8.0),
                backgroundColor: Color(0xFF156081)),
                onPressed: () async {
                  User? user = await _auth.registerUserWithEmailAndPassword(
                      emailController.text, passwordController.text);
                  if (passwordController.text != confirmController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Không khớp với Password")));
                  }

                  if (user != null) {
                    Provider.of<MyState>(context,listen:false).user.id = user.uid.toString();
                    mUser newUser = mUser(id: user.uid.toString(),name: fullnameController.text,);
                    await DbHelper.createUser(newUser);
                    Provider.of<MyState>(context,listen:false).user = (await DbHelper.getUserById(user.uid))!;
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Đã đăng ký thành công."),
                    ));
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Có lỗi đăng ký."),
                    ));
                  }
                },
                child: Text(
                  "Sign up",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
