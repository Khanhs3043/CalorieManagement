

import 'package:calopilot/models/myColor.dart';
import 'package:calopilot/screens/createNewFood.dart';
import 'package:calopilot/widgets/searchItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YourMealScreen extends StatefulWidget {
  const YourMealScreen({super.key});

  @override
  State<YourMealScreen> createState() => _YourMealScreenState();
}

class _YourMealScreenState extends State<YourMealScreen> {
  List<String> listfoods=['thịt chó', 'thịt gà', 'thịt bò','thịt vit', 'thịt chuột','a','b','c','d','e','f','g','h','i','j','k'];
  List<String> foods=[];
  TextEditingController searchController = TextEditingController();
  void search(String query){
    if(query.isEmpty) {
      setState(() {
        foods= listfoods;
      });
    } else {
      setState(() {
      foods = listfoods.where((e) => e.toLowerCase().contains(query.toLowerCase())).toList();
    });
    }
  }
  @override
  void initState() {
    search('');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<MyUI>(builder: (context, ui, child){
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top:80),
              child: foods.isEmpty? Center(child: Text('food not exist'),):ListView.builder(
                itemCount: foods.isEmpty? listfoods.length: foods.length,
                itemBuilder: (context, index) {
                  final item = foods.isEmpty?null:foods[index];
                  return SearchItem(
                      title: item!,
                      info: 'info',
                      onTap: (){
                        print('tap ${item} ');
                      });
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
                  icon: Icon(Icons.add,size: 30,color: Colors.white,),))
          ],
        ),
      );
    });
  }
}
