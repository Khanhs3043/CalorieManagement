import 'package:calopilot/models/exercise.dart';
import 'package:calopilot/models/myColor.dart';
import 'package:calopilot/provider/myState.dart';
import 'package:calopilot/screens/addScreen.dart';
import 'package:calopilot/services/dbHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CreateNewExerciseSceen extends StatefulWidget {
  const CreateNewExerciseSceen({super.key});

  @override
  State<CreateNewExerciseSceen> createState() => _CreateNewExerciseSceenState();
}

class _CreateNewExerciseSceenState extends State<CreateNewExerciseSceen> {
  var nameCon = TextEditingController();
  var burnedCon = TextEditingController();
  var timeCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Provider.of<MyUI>(context).color2,
      appBar: AppBar(
        backgroundColor: Provider.of<MyUI>(context).color5,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Create new exercise',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          alignment: Alignment.center,
          children: [Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25,),
              Text('Basic information',
                style: TextStyle(
                    color: Provider.of<MyUI>(context).color4,
                    fontSize: 18
                ),),
              Container(
                padding: const EdgeInsets.only(bottom: 15, right: 12, left: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Provider.of<MyUI>(context).color1,
                    boxShadow: [BoxShadow(
                        offset: const Offset(0,4),
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5
                    )]
                ),
                child: TextField(
                  controller: nameCon,
                  decoration: InputDecoration(
                      hintText: 'Name of exercise'
                  ),
                ),
              ),
              const SizedBox(height: 25,),
              Text('Calories burned',
                style: TextStyle(
                    color: Provider.of<MyUI>(context).color4,
                    fontSize: 18
                ),),
              Container(
                padding: const EdgeInsets.only(bottom: 15, right: 12, left: 12,top:20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Provider.of<MyUI>(context).color1,
                    boxShadow: [BoxShadow(
                        offset: const Offset(0,4),
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5
                    )]
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Burn ',style: TextStyle(
                            color: Color(0xff7e7e7f),
                            fontSize: 20
                        ),),
                        Container(
                          padding: EdgeInsets.only(bottom: 5),
                          width: 70,
                          height: 30,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: burnedCon,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20,color: Color(0xff7e7e7f)),
                          ),
                        ),
                        Text(' Kcal',style: TextStyle(
                            color: Color(0xff7e7e7f),
                            fontSize: 20
                        ),),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Time ',style: TextStyle(
                            color: Color(0xff7e7e7f),
                            fontSize: 20
                        ),),
                        Container(
                          padding: EdgeInsets.only(bottom: 5),
                          width: 70,
                          height: 30,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: timeCon,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20,color: Color(0xff7e7e7f)),
                          ),
                        ),
                        Text('  min',style: TextStyle(
                            color: Color(0xff7e7e7f),
                            fontSize: 20
                        ),),
                      ],
                    )
                  ],
                )

              ),
            ],
          ),
            Positioned(
              bottom: 50,
              child: ElevatedButton(onPressed: ()async{
                var burn = int.parse(burnedCon.text);
                var time = int.parse(timeCon.text);
                var name  = nameCon.text;
                Exercise exercise = Exercise(kcalPerMin: burn,name:name,duration: time,
                    userID: Provider.of<MyState>(context,listen: false).user.id
                );
                exercise.id = await DbHelper.createExercise(exercise);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddScreen()));
              },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blueGrey),
                    foregroundColor: MaterialStatePropertyAll(Colors.white),
                    padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 10,horizontal: 30))
                  ),
                  child: Text("Create exercise",style: TextStyle(fontSize: 18),)),
            )
          ]
        ),
      ),
    );
  }
}
