import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/food.dart';
import '../models/myColor.dart';
import '../widgets/nutritionChart.dart';
class FoodInfoScreen extends StatefulWidget {
   FoodInfoScreen({super.key, required this.food});
  Food food;
  @override
  State<FoodInfoScreen> createState() => _FoodInfoScreenState();
}

class _FoodInfoScreenState extends State<FoodInfoScreen> {
  var selectedItem = "g";
  var quantityController = TextEditingController();
  @override
  void initState() {
    quantityController.text = widget.food.amountOfServing.toString();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Provider.of<MyUI>(context).color5,
        foregroundColor: Provider.of<MyUI>(context).color1,
        title: Text(widget.food.name),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Card(
                        child: Center(
                          child: TextField(
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                border: InputBorder.none
                            ),
                            controller: quantityController,
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: Card(
                          child: Center(
                            child: DropdownButton(
                              value: selectedItem,
                              items: const [
                                DropdownMenuItem<String>(value: "g",child: Text('g'),),
                                DropdownMenuItem<String>(value: "ml",child: Text('ml'),)
                              ],
                              onChanged: <String>(val) {
                                setState(() {
                                  selectedItem = val;
                                });
                              },),
                          )
                      ))
                ],
              ),
              const SizedBox(height: 30,),
              NutritionChart(carbs: widget.food.carbs,fats: widget.food.fats,protein: widget.food.protein,kcal:widget.food.kcal ,),
              const SizedBox(height: 50,),
              ElevatedButton(onPressed: (){

              },
                style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 50,vertical: 10)),
                    backgroundColor: MaterialStatePropertyAll(Color(0xff82c9ea))
                ), child: const Text('Add to diary',style: TextStyle(color: Colors.white, fontSize: 18),),)
            ],
          ),
        ),
      ),
    );
  }
}
