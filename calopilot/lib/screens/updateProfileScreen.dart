import 'dart:core';
import 'dart:core';

import 'package:calopilot/models/goal.dart';
import 'package:calopilot/models/user.dart';
import 'package:calopilot/provider/myState.dart';
import 'package:calopilot/screens/mainScreen.dart';
import 'package:calopilot/services/calculator.dart';
import 'package:calopilot/services/dbHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  String selected = "Maintain weight";
  var age=0;
  var height=0.0, weight=0.0;
  var gender = 'female';
  var activityLevel = 'low';
  var selectedDate = DateTime.now();
  var heightCon = TextEditingController();
  var weightCon = TextEditingController();
  var ageCon = TextEditingController();
  int tdee = 0;
  int kpd = 0;
  int bmr = 0;
  double bmi = 0;
  calc(){
    bmi = Calculator.calculateBMI(weight, height);
    bmr = Calculator.calculateBMR(gender, weight, height, age).toInt();
    tdee = Calculator.calculateTDEE(double.parse(bmr.toString()), activityLevel).toInt();
    kpd = Calculator.calculateDailyCalories(double.parse(tdee.toString()), selected).toInt();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color(0xffe9e9e9),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Stack(
          children: [Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "GOAL",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color(0xff4d93d8),
                    ),
                  ),
                  const SizedBox(width: 20),
                  DropdownButton<String>(
                    focusColor: const Color(0xff707476),
                    underline: const SizedBox(),
                    style: const TextStyle(
                      color: Color(0xff707476),
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                    value: selected,
                    items: [
                      DropdownMenuItem<String>(
                        value: "Lose weight",
                        child: Text('Lose weight',),
                      ),
                      DropdownMenuItem<String>(
                        value: "Maintain weight",
                        child: Text('Maintain weight'),
                      ),
                      DropdownMenuItem<String>(
                        value: "Gain weight",
                        child: Text('Gain weight'),
                      ),
                    ],
                    onChanged: (val) {
                      setState(() {
                        selected = val!;
                        calc();
                      });
                    },
                  )
                ],
              ),
              const SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(
                    offset: Offset(0,4),
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.1)
                  )]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Kcal/day',style: TextStyle(fontSize: 20, color: Colors.grey,fontWeight: FontWeight.w500),),
                        Text('TDEE',style: TextStyle(fontSize:20, color: Colors.grey,fontWeight: FontWeight.w500),),
                        Text('BMR',style: TextStyle(fontSize: 20, color: Colors.grey,fontWeight: FontWeight.w500),),
                        Text('BMI',style: TextStyle(fontSize: 20, color: Colors.grey,fontWeight: FontWeight.w500),),
                      ],
                    ),
                    const SizedBox(width: 40,),
                    Column( crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('$kpd',style: TextStyle(fontSize: 20, color: Color(0xff4d93d8),fontWeight: FontWeight.w500)),
                        Text('$tdee',style: TextStyle(fontSize: 20, color: Color(0xff4d93d8),fontWeight: FontWeight.w500)),
                        Text('$bmr',style: TextStyle(fontSize: 20, color: Color(0xff4d93d8),fontWeight: FontWeight.w500)),
                        Text('${bmi.toStringAsFixed(2)}',style: TextStyle(fontSize: 20, color: Color(0xff4d93d8),fontWeight: FontWeight.w500))
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 25,),
              GestureDetector(
                onTap: (){
                  showDialog(context: context, builder: (context){
                    return AlertDialog(
                      title: Text('Enter your Height'),
                      content: TextField(
                        controller: heightCon,
                      ),
                      actions: [
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text('Cancel')),
                        TextButton(onPressed: (){
                          setState(() {
                            height = double.parse(heightCon.text.toString());
                            calc();
                          });
                          Navigator.pop(context);
                        }, child: Text('OK')),
                      ],
                    );
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Height',style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.w500),),
                    Text('$height cm',style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.w500),)
                  ],
                ),
              ),
               Container(height: 2,color: Colors.grey.shade400,),
              const SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  showDialog(context: context, builder: (context){
                    return AlertDialog(
                      title: Text('Enter your Weight'),
                      content: TextField(
                        controller: weightCon,
                      ),
                      actions: [
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text('Cancel')),
                        TextButton(onPressed: (){
                          setState(() {
                            weight = double.parse(weightCon.text.toString());
                            calc();
                          });
                          Navigator.pop(context);
                        }, child: Text('OK')),
                      ],
                    );
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Weight',style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.w500),),
                    Text('$weight kg',style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.w500),)
                  ],
                ),
              ),
              Container(height: 2,color: Colors.grey.shade400,),
              const SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  showDialog(context: context, builder: (context){
                    return AlertDialog(
                      title: Text('Enter your Age'),
                      content: TextField(
                        controller: ageCon,
                      ),
                      actions: [
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text('Cancel')),
                        TextButton(onPressed: (){
                          setState(() {
                            age = int.parse(ageCon.text.toString());
                            calc();
                          });
                          Navigator.pop(context);
                        }, child: Text('OK')),
                      ],
                    );
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Age',style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.w500),),
                    Text('$age',style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.w500),)
                  ],
                ),
              ),
              Container(height: 2,color: Colors.grey.shade400,),
              const SizedBox(height: 15,),
              // gender------------------------------------------------------------------------
              GestureDetector(
                onTap: (){
                  showDialog(context: context, builder: (context){
                    return AlertDialog(
                      title: Text('Your gender'),
                      content: Container(
                        height: 50,
                        child: Center(
                          child: DropdownButton<String>(
                            value: gender,
                            items: [
                            DropdownMenuItem<String>(child: Text("Female"), value: "female",),
                            DropdownMenuItem<String>(child: Text("Male"), value: "male",),
                              DropdownMenuItem<String>(child: Text("Other"), value: "other",)
                          ], onChanged: (String? value) {
                            setState(() {
                              gender = value!;
                              Navigator.pop(context);
                              calc();
                            });
                          },

                          ),
                        ),
                      ),

                    );
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Gender',style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.w500),),
                    Text('$gender',style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.w500),)
                  ],
                ),
              ),
              Container(height: 2,color: Colors.grey.shade400,),
              const SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  showDialog(context: context, builder: (context){
                    return AlertDialog(
                      title: Text('Your Activity Level'),
                      content: Container(
                        height: 50,
                        child: Center(
                          child: DropdownButton<String>(
                            value: activityLevel,
                            items: [
                              DropdownMenuItem<String>(child: Text("Very low"), value: "very low",),
                              DropdownMenuItem<String>(child: Text("Low"), value: "low",),
                              DropdownMenuItem<String>(child: Text("Moderate"), value: "moderate",),
                              DropdownMenuItem<String>(child: Text("High"), value: "high",),
                              DropdownMenuItem<String>(child: Text("Very high"), value: "very high",)
                            ], onChanged: (String? value) {
                            setState(() {
                              activityLevel = value!;
                              Navigator.pop(context);
                              calc();
                            });
                          },
                          ),
                        ),
                      ),

                    );
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Activity level',style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.w500),),
                    Text('$activityLevel',style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.w500),)
                  ],
                ),
              ),
              Container(height: 2,color: Colors.grey.shade400,),
              const SizedBox(height: 15,),
            ],
          ),
            Align(
              alignment: Alignment.bottomCenter,
                child: ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 12,horizontal: 60)),
                backgroundColor: MaterialStatePropertyAll(Color(0xff5e9ddb)),
                foregroundColor: MaterialStatePropertyAll(Colors.white)
              ),
              onPressed: ()async {
                String userId =  Provider.of<MyState>(context,listen:false).user.id;
                mUser user = mUser(id: userId,
                  name:  Provider.of<MyState>(context,listen: false).user.name,
                  height: height,
                  weight: weight,
                  age: age,
                  gender: gender,
                );
                Goal goal = Goal(userId: userId,kcal: kpd,weightGoal: selected);
                goal.id = await DbHelper.createGoal(userId, goal);
                await DbHelper.updateUser(user);
                Provider.of<MyState>(context,listen: false).user = (await DbHelper.getUserById(userId))!;
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));
              },
              child: Text('Continue',style: TextStyle(fontSize: 18),),))
          ]
        ),

      ),
    );
  }
}
