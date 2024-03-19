import 'package:calopilot/models/myColor.dart';
import 'package:calopilot/screens/profile.dart';
import 'package:calopilot/screens/yourMealScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'homeScreen.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  List screens = [HomeScreen(), YourMealScreen(),MainProfile()];
  @override

  Widget build(BuildContext context) {

    return Consumer<MyUI>(
        builder: (context, ui, child) {
          return Scaffold(
            backgroundColor: ui.color2,
              body: screens[selectedIndex],
              bottomNavigationBar: ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                child: Container(
                  color: ui.color1,
                  padding: EdgeInsets.symmetric(vertical: 10),

                  child: BottomNavigationBar(
                    backgroundColor: ui.color1,
                    elevation: 0,
                    iconSize: 30,
                    currentIndex: selectedIndex,
                    selectedItemColor: const Color(0xff60c9f3),
                    unselectedItemColor: const Color(0xffacacae),
                    onTap: (index){
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    items: const [
                      BottomNavigationBarItem(icon: Icon(Icons.home_filled),label: 'Home'),
                      BottomNavigationBarItem(icon: Icon(Icons.fastfood_outlined,),label: 'Your meal'),
                      BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile')
                    ],

                  ),
                ),
              ),
          );}
    );
  }
}
