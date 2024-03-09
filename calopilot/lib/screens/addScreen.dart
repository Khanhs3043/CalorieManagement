import 'package:calopilot/models/myColor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/searchItem2.dart';
class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
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
              final item = foods.isEmpty?null:foods[index];
              return SearchItem2(
                  title: item!,
                  info: 'info',
                  onTap: (){
                    print('tap ${item} ');
                  });
            },
          ),
        ),
      );
    });
  }
}
