

import 'package:calopilot/models/myColor.dart';
import 'package:calopilot/provider/myState.dart';
import 'package:calopilot/screens/createNewFood.dart';
import 'package:calopilot/screens/foodInfoScreen.dart';
import 'package:calopilot/services/dbHelper.dart';
import 'package:calopilot/widgets/searchItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/food.dart';
import '../models/foodLog.dart';


class YourMealScreen extends StatefulWidget {
  const YourMealScreen({super.key});

  @override
  State<YourMealScreen> createState() => _YourMealScreenState();
}
class _YourMealScreenState extends State<YourMealScreen> {
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
  didChangeDependencies(){
    super.didChangeDependencies();
    getYourFoods();
  }

  Future getYourFoods()async{
    listfoods = await DbHelper.getAllUserFoods(Provider.of<MyState>(context).user.id);
    search('');
  }
  @override
  Widget build(BuildContext context) {
    return Consumer2<MyUI, MyState>(builder: (context, ui,state, child){
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top:120),
              child: foods.isEmpty? Center(child: Text('food not exist'),)
                  :ListView.builder(
                itemCount: foods.isEmpty? listfoods.length: foods.length,
                itemBuilder: (context, index) {
                  final food = foods.isEmpty?null:foods[index];
                  return SearchItem(
                      onDelete: ()async{
                        await DbHelper.deleteFood(food.id);
                        state.updateState();
                      },
                      title: food!.name,
                      info: '${food.amountOfServing}g - ${food.kcal} kcal',
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>FoodInfoScreen(food: food)));
                        print('tap ${food.name}  ${food.id}');
                      },
                    onAdd: ()async{
                      FoodLog foodLog = FoodLog(userID: Provider.of<MyState>(context,listen: false).user.id, food: food);
                      await DbHelper.createFoodLog(foodLog);
                    },
                  );
                },
              ),
            ),
            Container(
              height: 140,
              color: Color(0xff155f82),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 50,),
                      const Text('Your meal', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20
                      ),),
                      const SizedBox(height: 15,),
                      Container(
                        width: MediaQuery.sizeOf(context).width - 40,
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
                          )),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top:40,
                right:0,
                child: IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (conext)=>CreateNewFoodSceen()));
                },
                  icon: const Icon(Icons.add,size: 30,color: Colors.white,),))
          ],
        ),
      );
    });
  }
}
