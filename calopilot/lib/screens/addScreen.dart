import 'package:calopilot/models/foodLog.dart';
import 'package:calopilot/models/myColor.dart';
import 'package:calopilot/provider/myState.dart';
import 'package:calopilot/screens/createNewFood.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/exercise.dart';
import '../models/food.dart';
import '../services/dbHelper.dart';
import '../widgets/searchItem.dart';
import '../widgets/searchItem2.dart';
import 'createNewExerciseScreen.dart';
import 'foodInfoScreen.dart';
class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  bool isFood = true;
  List<Food> listfoods = [];
  List<Food> foods=[];
  List<Exercise> listEx = [];
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
    getAllFoods();
    getAllEx();

  }

  Future getAllFoods()async{
    listfoods = await DbHelper.getAllFoods();
    search('');
  }
  Future getAllEx()async{
    listEx = await DbHelper.getAllExercises();
    search('');
  }
  @override
  Widget build(BuildContext context) {

    return Consumer2<MyUI,MyState>(builder: (context, ui,state, child){
      return Scaffold(
        appBar: AppBar(

          bottom:  PreferredSize(preferredSize: Size(MediaQuery.sizeOf(context).width -40, 30),
          child: Container(
              margin: const EdgeInsets.only(bottom: 10,),
              width: MediaQuery.sizeOf(context).width -40,
              height: 35,
              child: SearchBar(
                controller: searchController,
                backgroundColor: MaterialStatePropertyAll(ui.color1),
                hintText: 'Search...',
                hintStyle: const MaterialStatePropertyAll(TextStyle(color: Color(0xff545859),fontWeight: FontWeight.normal)),
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
                      child: const Icon(Icons.cancel)
                  )
                ],
                onChanged: (query){
                  search(query);
                },
              )
          )),
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Icon(Icons.directions_walk_outlined),
              const SizedBox(width: 3,),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Switch(
                  activeColor: Colors.white,
                  value: isFood,
                  onChanged: (bool value) {
                    setState(() {
                      isFood = value;
                    });
                  },

                ),
              ),const SizedBox(width: 5,),
              const Icon(Icons.fastfood_outlined),
            ],
          ),
          backgroundColor: const Color(0xff155f82),
          foregroundColor: Colors.white,
          actions: [IconButton(onPressed: () {
            isFood?Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateNewFoodSceen())):
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateNewExerciseSceen()));
          }, icon: const Icon(Icons.add),)],
        ),
        backgroundColor: ui.color2,
        body: isFood?Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: foods.isEmpty? const Center(child: Text('food not exist'),):ListView.builder(
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
                    Provider.of<MyState>(context,listen: false).updateState();
                    await DbHelper.createFoodLog(foodLog);
              },);
            },
          ),
        ):
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
              child: listEx.isEmpty? const Center(child: Text('exercise not exist'),):
              ListView.builder(
                itemCount: listEx.isEmpty? listEx.length: listEx.length,
                itemBuilder: (BuildContext context, int index) {

                  var exercise = listEx[index];
                  return SearchItem(
                      title: exercise.name,
                      info: '${exercise.duration} min - ${exercise.kcalPerMin} kcal',
                      onTap: (){
                        showModalBottomSheet(context: context, builder: (context){
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                            height: 300,
                            width: MediaQuery.sizeOf(context).width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: ui.color2,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.sizeOf(context).width-30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: ui.color1
                                  ),
                                  child: Column(
                                    children: [
                                      Text('${exercise.name}'),
                                      Text('${exercise.duration} min - ${exercise.kcalPerMin} kcal')
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                      },
                      onAdd: ()async{
                        //await DbHelper.a
                      },
                    onDelete: () async{
                        await DbHelper.deleteExercise(exercise.id);

                        state.updateState();
                    },);
                },),
            )
      );
    });
  }
}
