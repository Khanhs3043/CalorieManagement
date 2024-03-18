import 'package:calopilot/models/foodLog.dart';
import 'package:calopilot/models/myColor.dart';
import 'package:calopilot/screens/foodLogInfoScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeFood extends StatelessWidget {
  HomeFood({super.key,  required this.foodLog});
  FoodLog foodLog;

  @override
  Widget build(BuildContext context) {
    foodLog.calc();
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>FoodLogInfoScreen(foodLog: foodLog,)));
      },
      child: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(top: 7,bottom: 7,left: 20,right: 5),
        decoration: BoxDecoration(
          color: Provider.of<MyUI>(context).color1,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(
            blurRadius: 10,
            color: Colors.black.withOpacity(0.07),
            offset: Offset(0,4)
          )]
        ),
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(foodLog.food.name,style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Provider.of<MyUI>(context).color4,
                    ),),
                    Text(
                      "${foodLog.quantity} - ${foodLog.kcal} kcal",
                      style: TextStyle(
                      fontSize: 16,
                      color: Color(0xffadadae),
                    ),),
                  ],
                ),
              ],
            ),
            IconButton(onPressed: (){}, icon: Icon(Icons.cancel_rounded,size: 25,color: Color(0xffadadae),),)
          ],
        ),
      ),
    );
  }
}
