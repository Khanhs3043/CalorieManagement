import 'package:calopilot/services/calculator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// ignore: unused_import
import 'package:provider/provider.dart';
// ignore: unused_import
import 'package:calopilot/models/myColor.dart';
// ignore: unused_import
import 'package:calopilot/screens/settingScreen.dart';

import '../models/user.dart';
import '../provider/myState.dart';


class MainProfile extends StatefulWidget {
  const MainProfile({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainProfile createState() => _MainProfile();
}

class _MainProfile extends State<MainProfile> {
  @override
  Widget build(BuildContext context) {
    mUser user = Provider.of<MyState>(context,listen: false).user;
    print(user.name);
    print(user.gender);
    return Scaffold(
      backgroundColor: Provider.of<MyUI>(context).color2,
      appBar: AppBar(
        backgroundColor: Provider.of<MyUI>(context).appBarColor,
        foregroundColor: Colors.white,
        title:  Text('${Provider.of<MyState>(context,listen:false).user.name}'),
        leading: const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Icon(Icons.account_circle,size: 40,),
        ),
        actions: [IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsScreen()));
        }, icon:const Icon(Icons.settings,size: 35,))],
      ),
      body:  Padding(
        padding:  const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Information',style: TextStyle(color: Colors.grey.shade600,fontSize: 18),),
              const SizedBox(height: 5,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Provider.of<MyUI>(context).color1,
                  boxShadow: [BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0,4)
                  )]
                ),
                child: Padding(
                  padding:  const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Name",style: TextStyle(fontSize: 18),),
                          Text("${user.name}",style: TextStyle(fontSize: 18),),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Container(height: 1.2,color: Colors.grey.shade300,width: MediaQuery.sizeOf(context).width,),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Gender",style: TextStyle(fontSize: 18),),
                          Text("${user.gender}",style: TextStyle(fontSize: 18),),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Container(height: 1.2,color: Colors.grey.shade300,width: MediaQuery.sizeOf(context).width,),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Age",style: TextStyle(fontSize: 18),),
                          Text("${user.age}",style: TextStyle(fontSize: 18),),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Text('BMI',style: TextStyle(color: Colors.grey.shade600,fontSize: 18),),
              const SizedBox(height: 5,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Provider.of<MyUI>(context).color1,
                    boxShadow: [BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0,4)
                    )]
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('BMI',style: TextStyle(fontSize: 18,color: Colors.grey),),
                      Text('${Calculator.calculateBMI(user.weight!, user.height!).toStringAsFixed(2)}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,
                          color: Color(0xff45b0e0)),),
                      Text('Normal',style: TextStyle(fontSize: 18,color: Colors.grey),),
                      Container(height: 1.2,color: Colors.grey.shade300,width: MediaQuery.sizeOf(context).width,),
                      const SizedBox(height: 15,),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Text('160 cm',style: TextStyle(fontSize: 18),),
                                Text('${user.height}',style: TextStyle(fontSize: 14,color: Colors.grey),),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Text('48 kg',style: TextStyle(fontSize: 18),),
                                Text('${user.weight}',style: TextStyle(fontSize: 14,color: Colors.grey),),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Text('Drink water',style: TextStyle(color: Colors.grey.shade600,fontSize: 18),),
              const SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.only(top: 20,bottom:20, left: 25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Provider.of<MyUI>(context).color1,
                    boxShadow: [BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0,4)
                    )]
                ),
                child: Row(
                  children: [
                     const Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('1950 ', style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff45b0e0)
                              ),),
                              Text('ml', style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff45b0e0)
                              ),)
                            ],
                          ),
                          Text('Daily goal drink water',style: TextStyle(color: Colors.grey),),
                          const SizedBox(height: 3,),
                          Row(children: [
                            Icon(Icons.timer_sharp,color: Colors.grey,),
                            Text('  Last drink: 11:11 AM',style: TextStyle(color: Colors.grey),),
                          ],),
                        ],
                      ),


                    ),
                    Expanded(
                      flex: 3,
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(onPressed: (){},
                                    icon: Icon(Icons.add_circle,size: 30,color: Colors.grey,)),
                                IconButton(onPressed: (){},
                                    icon: Icon(Icons.remove_circle,size: 30,color: Colors.grey))
                              ],
                            ),
                          ),
                          Transform.rotate(
                            angle: 3.14*3/2,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)
                              ),
                             
                              height: 40,
                              width: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: const LinearProgressIndicator(
                                  valueColor:AlwaysStoppedAnimation<Color>(Color(0xff45b0e0)) ,
                                  value: 0.5,
                                  minHeight: 40,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
