
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class NutritionChart extends StatelessWidget {
  NutritionChart({super.key,this.carbs = 0, this.fats = 0, this.protein = 0, this.kcal = 0});
  int carbs ;
  int fats;
  int protein;
  int kcal;
  @override
  Widget build(BuildContext context) {

    return  SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: 200,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              alignment: Alignment.center,
              children: [PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(value: double.parse(carbs.toString()),
                        color:const Color(0xfff89fee),),
                    PieChartSectionData(value: double.parse(fats.toString()),color:const Color(
                        0xfff4e885)),
                    PieChartSectionData(value: double.parse(protein.toString()),color:const Color(
                        0xff6ed7e7))
                  ],
                  centerSpaceRadius: 50
                ),

              ),
                Text('$kcal',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xfff89fee),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Text("Carbs", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
                      ],
                    ),
                    Text('$carbs g',style: const TextStyle(fontSize: 16),),
                  ],
                ),

                Row(
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xfff4e885),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Text("Fats", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
                  ],
                ),
                Text('$fats g',style: const TextStyle(fontSize: 16),),
                Row(
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff6ed7e7),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Text("Protein ", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
                  ],
                ),
                Text('$protein g',style: const TextStyle(fontSize: 16),),
              ],
            ),
          )
        ],
      ),
    );
  }
}
