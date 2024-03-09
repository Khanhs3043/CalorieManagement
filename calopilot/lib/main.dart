import 'package:calopilot/screens/addScreen.dart';
import 'package:calopilot/screens/homeScreen.dart';
import 'package:calopilot/screens/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/myColor.dart';


void main() {
  runApp(const CaloPilot());
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
       //ChangeNotifierProvider(create: (context)=>())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainScreen()
      ),
    );
  }
}

