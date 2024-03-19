import 'package:calopilot/models/foodLog.dart';
import 'package:calopilot/models/myColor.dart';
import 'package:calopilot/provider/myState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/food.dart';
import '../services/dbHelper.dart';
import '../widgets/searchItem2.dart';
import 'foodInfoScreen.dart';
class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  List<Food> listfoods = [];
  List<Food> foods=[];
  TextEditingController searchController = TextEditingController();
  void search(String query){
    if(query.isEmpty) {
      setState(() {
        foods= listfoods;
      });
    } else {
      setState(() {
        foods = listfoods.where((e) => e.name.toLowerCase().contains(query.toLowerCase())).toList();
      });
    }
  }
  @override
  void initState() {
    getAllFoods();
    super.initState();
  }
  Future getAllFoods()async{
    listfoods = await DbHelper.getAllFoods();
    search('');
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<MyUI>(builder: (context, ui, child){
      return Scaffold(
        appBar: AppBar(

          bottom:  PreferredSize(preferredSize: Size(MediaQuery.sizeOf(context).width -40, 30),
          child: Container(
              margin: EdgeInsets.only(bottom: 10,),
              width: MediaQuery.sizeOf(context).width -40,
              height: 35,
              child: SearchBar(
                controller: searchController,
                backgroundColor: MaterialStatePropertyAll(ui.color1),
                hintText: 'Search...',
                hintStyle: MaterialStatePropertyAll(TextStyle(color: Color(0xff545859),fontWeight: FontWeight.normal)),
                textStyle:  MaterialStatePropertyAll(TextStyle(color: ui.color4)),
                leading: const Icon(Icons.search,color: Color(0xff545859),),
                trailing:[
                  GestureDetector(
                      onTap: (){
                        searchController.text = '';
                        setState(() {
                          search('');
                        });
                      },
                      child: Icon(Icons.cancel)
                  )
                ],
                onChanged: (query){
                  search(query);
                },
              )
          )),
          title: Center(
              child: DropdownButton<String>(
                underline: Container(),
                value: 'dinner',
                dropdownColor: const Color(0xff155f82),
                items: const [
                  DropdownMenuItem(child: Text('Dinner'),value: 'dinner',),
                  DropdownMenuItem(child: Text('Breakfast'),value: 'breakfast',),
                  DropdownMenuItem(child: Text('Lunch'),value: 'lunch',)
                ], onChanged: (value) {  },
              ),
          ),
          backgroundColor: const Color(0xff155f82),
          foregroundColor: Colors.white,
          actions: [IconButton(onPressed: () {  }, icon: Icon(Icons.add),)],
        ),
        backgroundColor: ui.color2,
        body: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: foods.isEmpty? Center(child: Text('food not exist'),):ListView.builder(
            itemCount: foods.isEmpty? listfoods.length: foods.length,
            itemBuilder: (context, index) {
              final food = foods.isEmpty?null:foods[index];
              return SearchItem2(
                  title: food!.name,
                  info: '${food.amountOfServing}g - ${food.kcal} kcal',
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>FoodInfoScreen(food: food)));
                  }, onAdd: ()async{
                    FoodLog foodLog = FoodLog(userID: Provider.of<MyState>(context,listen: false).user.id, food: food);
                    await DbHelper.createFoodLog(foodLog);
              },);
            },
          ),
        ),
      );
    });
  }
}
