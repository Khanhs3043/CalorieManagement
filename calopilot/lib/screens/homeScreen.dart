
import 'package:calopilot/models/food.dart';
import 'package:calopilot/models/foodLog.dart';
import 'package:calopilot/models/myColor.dart';
import 'package:calopilot/provider/myState.dart';
import 'package:calopilot/screens/addScreen.dart';
import 'package:calopilot/screens/updateProfileScreen.dart';
import 'package:calopilot/services/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/goal.dart';
import '../widgets/home_food.dart';
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var listExLog = [];
  var listFoodLog = [];
  var goal ;
  int remaining =0;
  int eaten = 0;
  int burned = 0;
  int protein = 0;
  int carbs = 0;
  int fats = 0;
  @override
  didChangeDependencies(){
    super.didChangeDependencies();
    getYourFoodLogs();

  }
  Future  getYourFoodLogs()async{
     listFoodLog = await DbHelper.getAllFoodLogs(Provider.of<MyState>(context,listen: false).user.id);
     goal = await DbHelper.getGoal(Provider.of<MyState>(context,listen: false).user.id);

     setState(() {
     });

  }
  @override
  Widget build(BuildContext context) {
    remaining =0;
     eaten = 0;
     burned = 0;
     protein = 0;
     carbs = 0;
     fats = 0;

    for(FoodLog i in listFoodLog){
      carbs += i.carbs;
      fats += i.fats;
      protein += i.protein;
      eaten += i.kcal;
    }
    remaining = goal.kcal - eaten+ burned;
    bool state = Provider.of<MyState>(context).isChanged;
    return Consumer<MyUI>(
      builder: (BuildContext context, MyUI ui, Widget? child) {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
          onPressed: ()async {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddScreen()));},
        //Navigator.push(context, MaterialPageRoute(builder: (context)=>const UpdateProfileScreen()));},
          backgroundColor: ui.color3,
          foregroundColor: const Color(0xffadadae),
          child: const Icon(Icons.add,size: 30,),
        ),
        backgroundColor: Colors.transparent,
        body: goal==null?const Center(child: CircularProgressIndicator(),):Stack(
          children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 260,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: [
                         Column(
                           children: [
                              Stack(
                               alignment: Alignment.center,
                               children: [
                                 SizedBox(height: 55,
                                   width: 55,
                                   child: CircularProgressIndicator(
                                     value:  carbs/100,
                                     valueColor: AlwaysStoppedAnimation<Color>(Color(0xff37718c)),
                                     backgroundColor: Color(0xffadadae),
                                     strokeCap: StrokeCap.round,
                                     strokeWidth: 5,
                                   ),
                                 ),
                                 Text('Carbs'),
                               ]
                             ),
                             Text('$carbs/100'),
                           ],
                         ),
                         Column(
                           children: [
                             Stack(
                                 alignment: Alignment.center,
                                 children: [
                                   SizedBox(height: 55,
                                     width: 55,
                                     child: CircularProgressIndicator(
                                       value: protein/55,
                                       valueColor: AlwaysStoppedAnimation<Color>(Color(0xff37718c)),
                                       backgroundColor: Color(0xffadadae),
                                       strokeCap: StrokeCap.round,
                                       strokeWidth: 5,
                                     ),
                                   ),
                                   Text('Protein'),
                                 ]
                             ),
                             Text('$protein/150'),
                           ],
                         ),
                         Column(
                           children: [
                             Stack(
                                 alignment: Alignment.center,
                                 children: [
                                   SizedBox(height: 55,
                                     width: 55,
                                     child: CircularProgressIndicator(
                                       value: fats/55,
                                       valueColor: AlwaysStoppedAnimation<Color>(Color(0xff37718c)),
                                       backgroundColor: Color(0xffadadae),
                                       strokeCap: StrokeCap.round,
                                       strokeWidth: 5,
                                     ),
                                   ),
                                   Text('Fats'),
                                 ]
                             ),
                             Text('$fats/55'),
                           ],
                         ),
                       ],
                      ),
                  const SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                        onTap:(){},
                            child: const Text('-100',style: TextStyle(color: Color(0xffadadae),fontSize: 18,fontWeight: FontWeight.w500),)),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: Column(
                            children: [
                              const SizedBox(height: 7,),
                              LinearProgressIndicator(
                              minHeight: 12,
                              value: 0.4,
                              backgroundColor: ui.color3,
                              borderRadius : BorderRadius.circular(30),
                              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xff60c9f3)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              Text('Water',style: TextStyle(color: ui.color4),),
                              Text('650/1800 ml',style: TextStyle(color: ui.color4))
                            ],)
                            ]
                          ),
                        ),
                        const SizedBox(width: 10,),
                        GestureDetector(
                            onTap: (){},
                            child: const Text('+100',style: TextStyle(color: Color(0xff60c9f3),fontSize: 18,fontWeight: FontWeight.w500),)),
                      ],
                    ),
                  ),
                    const SizedBox(height: 20,),

                    listFoodLog.isEmpty?const SizedBox():
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(' Eaten',style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ui.color4
                        ),),
                        Column(
                            children:listFoodLog.map(
                                    (foodLog) => HomeFood(
                                    foodLog: foodLog)).toList()),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    listExLog.isEmpty?const SizedBox():
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(' Exercise',style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ui.color4
                        ),),
                        Column(
                            children:listExLog.map(
                                    (exLog) => Stack(
                                      alignment: Alignment.centerRight,
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(exLog.food.name,style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Provider.of<MyUI>(context).color4,
                                                ),),
                                                Text(
                                                  "${exLog.quantity}min - ${exLog.kcal} kcal",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xffadadae),
                                                  ),),
                                              ],
                                            ),
                                          ],
                                        ),
                                        IconButton(onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text("Notify"),
                                                content: const Text("You want to delete?"),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: ()async {
                                                      await DbHelper.deleteFoodLog(exLog.id);
                                                      Provider.of<MyState>(context,listen: false).updateState();
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: const Text('OK'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: const Text('Cancel'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );

                                        }, icon: Icon(Icons.cancel_rounded,size: 25,color: Color(0xffadadae),),)
                                      ],
                                    ),).toList()),
                      ],
                    ),
                    const SizedBox(height: 50,)

                  ],
                  ),
                ),
              ),

            Container(
              height: 230,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: ui.color3,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  boxShadow: [BoxShadow(
                    blurRadius: 20,
                    color: Colors.black.withOpacity(0.07),

                  )]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Today',style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: ui.color4
                  ),),
                  const SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(children: [
                          const SizedBox(height: 8,),
                          Text('Eaten',style: TextStyle(
                              fontSize: 16,
                              color: ui.color4
                          ),),
                          Text('$eaten',style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: ui.color4
                          ),)
                        ],),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                               SizedBox(height: 110,width: 110,
                                child: CircularProgressIndicator(
                                  strokeWidth: 8,
                                  strokeCap: StrokeCap.round,
                                  value: (goal.kcal - remaining)/goal.kcal,
                                  backgroundColor: Color(0xffadadae),
                                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xff84E291)),
                                ),
                              ),
                              Text('$remaining',style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: ui.color4
                              ),),
                               Padding(
                                padding: EdgeInsets.only(top:40),
                                child: Text('remaining',style: TextStyle(color: ui.color4),),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(children: [
                          const SizedBox(height: 8,),
                          Text('Burned',style: TextStyle(
                              fontSize: 16,
                              color: ui.color4
                          ),),
                          Text('$burned',style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: ui.color4
                          ),)
                        ],),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]
        ),
      );},
    );
  }
}
