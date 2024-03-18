import 'package:calopilot/models/foodLog.dart';
import 'package:calopilot/models/myColor.dart';
import 'package:calopilot/widgets/nutritionChart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class FoodLogInfoScreen extends StatefulWidget {
  const FoodLogInfoScreen({super.key, required this.foodLog});
  final FoodLog foodLog;
  @override
  State<FoodLogInfoScreen> createState() => _FoodLogInfoScreenState();
}

class _FoodLogInfoScreenState extends State<FoodLogInfoScreen> {
  var selectedItem = "g";
  var quantityController = TextEditingController();
  @override
  void initState() {
    quantityController.text = widget.foodLog.quantity.toString();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Provider.of<MyUI>(context).color5,
        foregroundColor: Provider.of<MyUI>(context).color1,
        title: Text('title'),
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
              NutritionChart(carbs: widget.foodLog.carbs,fats: widget.foodLog.fats,protein: widget.foodLog.protein,kcal:widget.foodLog.kcal ,),
              const SizedBox(height: 50,),
              ElevatedButton(onPressed: (){},
                style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 50,vertical: 10)),
                  backgroundColor: MaterialStatePropertyAll(Color(0xff82c9ea))
                ), child: const Text('Update to diary',style: TextStyle(color: Colors.white, fontSize: 18),),)
            ],
          ),
        ),
      ),
    );
  }
}
