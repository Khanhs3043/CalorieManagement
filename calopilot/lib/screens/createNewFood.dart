

import 'package:calopilot/models/myColor.dart';
import 'package:calopilot/services/dbHelper.dart';
import 'package:calopilot/utils/dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/food.dart';
import '../provider/myState.dart';

class CreateNewFoodSceen extends StatefulWidget {
  const CreateNewFoodSceen({super.key});

  @override
  State<CreateNewFoodSceen> createState() => _CreateNewFoodSceenState();
}

class _CreateNewFoodSceenState extends State<CreateNewFoodSceen> {
  bool gr = true;
  bool ml = false;
  int kcal = 0;
  TextEditingController nameCon = TextEditingController();
  TextEditingController servingCon = TextEditingController();
  TextEditingController nameOfServingCon = TextEditingController();
  TextEditingController carbCon = TextEditingController();
  TextEditingController fatCon = TextEditingController();
  TextEditingController proteinCon = TextEditingController();
  TextEditingController kcalCon = TextEditingController();
  int carb = 0;
  int fat = 0;
  int pro = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer2<MyUI,MyState>(
      builder: (context, ui,state, child){
      return Scaffold(
        backgroundColor: ui.color2,
        appBar: AppBar(
          backgroundColor: ui.color5,
          foregroundColor: Colors.white,

          title: Text('Create new food',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),),
        ),
        body: Stack(
          children: [Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25,),
                  Text('Basic information',
                  style: TextStyle(
                    color: ui.color4,
                    fontSize: 18
                  ),),
                  Container(
                    padding: const EdgeInsets.only(bottom: 15, right: 12, left: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ui.color1,
                      boxShadow: [BoxShadow(
                        offset: const Offset(0,4),
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5
                      )]
                    ),
                    child: TextField(
                      controller: nameCon,
                      decoration: InputDecoration(
                        hintText: 'Name of food'
                      ),
                    ),
                  ),
                  const SizedBox(height: 25,),
                  Text('Serving',
                    style: TextStyle(
                        color: ui.color4,
                        fontSize: 18
                    ),),
                  Container(
                    padding: const EdgeInsets.only(bottom: 15, right: 12, left: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: ui.color1,
                        boxShadow: [BoxShadow(
                            offset: const Offset(0,4),
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5
                        )]
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: nameOfServingCon,
                        decoration: InputDecoration(
                            hintText: 'Name of serving'
                        ),
                      ),
                        const SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('1 serving =',
                            style: TextStyle(
                              color: Color(0xff7e7e7f),
                              fontSize: 20
                            ),),
                            const SizedBox(width: 5,),
                             Container(
                              padding: EdgeInsets.only(bottom: 5),
                              width: 70,
                              height: 30,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: servingCon,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20,color: Color(0xff7e7e7f)),
                            ),
                            )],
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                            const SizedBox(width: 10,),
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: gr?MaterialStatePropertyAll(ui.color5):const MaterialStatePropertyAll(Color(0xff7e7e7f))
                                  ),
                                  onPressed: (){
                                    gr = true;
                                    ml = false;
                                    ui.change();
                                  },
                                  child: Text('grams (g)',
                                    style: TextStyle(color: Colors.white),)),
                            ),
                            const SizedBox(width: 20,),
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: ml?MaterialStatePropertyAll(ui.color5):const MaterialStatePropertyAll(Color(0xff7e7e7f))
                                ),
                                  onPressed: (){
                                    gr = false;
                                    ml = true;
                                    ui.change();
                                  },
                                  child: Text('milliliter (ml)',
                                  style: TextStyle(color: Colors.white,),)),
                            ),
                            const SizedBox(width: 10,),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 25,),
                  Text('Nutrition per 100g/ml',
                    style: TextStyle(
                        color: ui.color4,
                        fontSize: 18
                    ),),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: ui.color1,
                        boxShadow: [BoxShadow(
                            offset: const Offset(0,4),
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5
                        )]
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text('Carbs',
                                style: TextStyle(
                                  fontSize: 18,
                                  color:Color(0xff7e7e7f)
                                ),),
                                const SizedBox(width: 10,),
                                Container(
                                  height: 50,
                                  padding: EdgeInsets.only(bottom: 15),
                                  width: 70,
                                  child: TextField(
                                    onChanged: (val){
                                      fat =fatCon.text.isEmpty?0: int.parse(fatCon.text);
                                      carb =carbCon.text.isEmpty?0: int.parse(carbCon.text);
                                      pro =proteinCon.text.isEmpty?0: int.parse(proteinCon.text);
                                      kcal =carb*4 + fat*9 + pro*4;
                                      setState(() {

                                        kcalCon.text = kcal.toString();
                                      });
                                    },
                                    keyboardType: TextInputType.number,
                                    controller: carbCon,
                                    textAlign: TextAlign.center,
                                    textAlignVertical: TextAlignVertical.top,
                                    style: TextStyle(fontSize: 18,color: Color(0xff7e7e7f)),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      border: UnderlineInputBorder()
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Fats',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color:Color(0xff7e7e7f)
                                  ),),
                                const SizedBox(width: 10,),
                                Container(
                                  height: 50,
                                  padding: EdgeInsets.only(bottom: 15),
                                  width: 70,
                                  child: TextField(
                                    onChanged: (val){
                                      fat =fatCon.text.isEmpty?0: int.parse(fatCon.text);
                                      carb =carbCon.text.isEmpty?0: int.parse(carbCon.text);
                                      pro =proteinCon.text.isEmpty?0: int.parse(proteinCon.text);
                                      kcal =carb*4 + fat*9 + pro*4;
                                      setState(() {
                                        kcalCon.text = kcal.toString();
                                      });
                                    },
                                    keyboardType: TextInputType.number,
                                    controller: fatCon,
                                    textAlign: TextAlign.center,
                                    textAlignVertical: TextAlignVertical.top,
                                    style: TextStyle(fontSize: 18,color: Color(0xff7e7e7f)),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.zero,
                                        border: UnderlineInputBorder()
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Protein',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color:Color(0xff7e7e7f)
                                  ),),
                                const SizedBox(width: 10,),
                                Container(
                                  height: 50,
                                  padding: EdgeInsets.only(bottom: 15),
                                  width: 70,
                                  child: TextField(
                                    onChanged: (val){
                                      fat =fatCon.text.isEmpty?0: int.parse(fatCon.text);
                                      carb =carbCon.text.isEmpty?0: int.parse(carbCon.text);
                                      pro =proteinCon.text.isEmpty?0: int.parse(proteinCon.text);
                                      kcal =carb*4 + fat*9 + pro*4;
                                      setState(() {
                                        kcalCon.text = kcal.toString();
                                      });
                                    },
                                    keyboardType: TextInputType.number,
                                    controller: proteinCon,
                                    textAlign: TextAlign.center,
                                    textAlignVertical: TextAlignVertical.top,
                                    style: TextStyle(fontSize: 18,color: Color(0xff7e7e7f)),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.zero,
                                        border: UnderlineInputBorder()
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Expanded(
                          child: Center(
                            child: Column(
                              children: [
                                const Text('Kcal',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color:Color(0xff7e7e7f)
                                  ),),
                                 SizedBox(
                                  width: 70,
                                    height: 40,
                                    child: TextField(
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xff4d96c0),
                                        fontWeight: FontWeight.bold
                                      ),
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      controller: kcalCon,
                                    ))
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ),
                  const SizedBox(height: 100,)
                ],
              ),
            ),
          ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ElevatedButton(onPressed: ()async{
                  Food food = Food(
                    name: nameCon.text,
                    nameOfServing: nameOfServingCon.text,
                    amountOfServing: int.parse(servingCon.text),
                    carbs: int.parse(carbCon.text),
                    fats: int.parse(fatCon.text),
                    protein: int.parse(proteinCon.text),
                    kcal: int.parse(kcalCon.text),
                    userID: state.user.id
                  );
                  try{
                    print(food.userID);
                    food.id = await DbHelper.createFood(food);
                    Utils.showSnackbar(context, "Add new food successfully!");
                    Navigator.pop(context);
                    state.isChanged;
                    state.updateState();
                  }catch(er){
                    Utils.showSnackbar(context, er.toString());
                  }

                },
                    style: ButtonStyle(
                        padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 50)),
                        backgroundColor: MaterialStatePropertyAll(ui.color5)
                    ),
                    child: const Text('Done',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white
                    ),)),
              ),
            )
          ]
        ),
      );}
    );
  }
}
