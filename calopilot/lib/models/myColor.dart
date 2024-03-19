import 'package:flutter/material.dart';

class MyUI with ChangeNotifier{
  bool isDark = false;
  Color? color1= Color(0xffffffff);
  Color? color2= Color(0xfff0f0f1);
  Color? color3= Color(0xffbfe3f4);
  Color? color4= Color(0xff000001);
  Color? color5= Color(0xff155f82);
  Color? textColor = Color(0xff000000);
  Color? appBarColor = Color(0xff37718c);
  
  switchTheme(){
    if(!isDark){
      color1 = Color(0xff262627);
      color2= Color(0xff0c0c0d);
      color3= Color(0xff37718c);
      color4= Color(0xffffffff);
      textColor = Color(0xffffffff);
      appBarColor = Color(0xff37718c);
      isDark = true;
    }else{
      color1 = Color(0xffffffff);
      color2= Color(0xfff0f0f1);
      color3= Color(0xffbfe3f4);
      color4= Color(0xff000001);
      textColor = Color(0xff000001);
      appBarColor = Color(0xff37718c);
      isDark = false;
    }
    notifyListeners();
  }
  change(){ notifyListeners();}
}
