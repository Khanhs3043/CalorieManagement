import 'package:calopilot/provider/myState.dart';
import 'package:calopilot/screens/loginScreen.dart';
import 'package:calopilot/screens/siginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'models/myColor.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid ?
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyCs11_NkkMjt_8LBru0iOqSV_eAH3K-C-k',  // current_key
          appId: '1:255174626591:android:39cd442f84f0b80a19342a',  // mobilesdk_app_id
          messagingSenderId: '255174626591',  // project_number
          projectId: 'calopilot'  // project_id
      )
  ) : await Firebase.initializeApp();

  runApp(CaloPilot());

}

class CaloPilot extends StatefulWidget {
  const CaloPilot({super.key});

  @override
  State<CaloPilot> createState() => _CaloPilotState();
}

class _CaloPilotState extends State<CaloPilot> {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> MyUI()),
        ChangeNotifierProvider(create: (context)=>MyState())
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home:LoginScreen()
      ),
    );
  }
}

