import 'package:flutter/material.dart';

class MyUI with ChangeNotifier{
  bool isDark = false;
  Color? color1= Color(0xffffffff);
  Color? color2= Color(0xfff0f0f1);
  Color? color3= Color(0xffbfe3f4);
  Color? color4= Color(0xff000001);

  DarkTheme(bool isDark){
    if(!isDark){
      color1 = Color(0xffffffff);
      color2= Color(0xfff0f0f1);
      color3= Color(0xffbfe3f4);
      color4= Color(0xff000001);
    }else{
      color1 = Color(0xff262627);
      color2= Color(0xff0c0c0d);
      color3= Color(0xff262627);
      color4= Color(0xffffffff);
    }
    notifyListeners();
  }
}