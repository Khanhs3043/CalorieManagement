import 'package:calopilot/models/myColor.dart';
import 'package:calopilot/services/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class SearchItem extends StatefulWidget {
  String title;
  String info;
  final Function onTap;
  final Function onDelete;
  final Function onAdd;
  SearchItem({super.key, required this.title, required this.info, required this.onTap, required this.onDelete(),required this.onAdd});

  @override
  State<SearchItem> createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  bool isAdd = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<MyUI>(
      builder: (context,ui,child){
      return GestureDetector(
        onTap: (){
          widget.onTap();
        },
        child: Container(
          margin: EdgeInsets.only(top:10),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: ui.color1,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                offset: const Offset(0,4),
                blurRadius: 5
              )
            ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color:ui.color4 ),),
                  Text(widget.info,
                  style: TextStyle(
                    fontSize: 17,
                    color: Color(0xff939596)
                  ),)
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                        showDialog(context: context,
                            builder: (context){
                              return AlertDialog(
                                actionsAlignment: MainAxisAlignment.center,
                                title: const Text("Delete this item?",textAlign: TextAlign.center ,style: TextStyle(fontSize: 20),),
                                actions: [
                                  TextButton(onPressed: ()async{
                                    await widget.onDelete();
                                    Navigator.pop(context);
                                  }, child: Text("OK")),
                                  TextButton(onPressed: (){Navigator.pop(context);},
                                      child: Text("Cancel")),
                                ],
                              );
                            });
                    },
                      child: const Icon(Icons.cancel_rounded,color: Color(0xff7e7e7f),size: 30,)),
                  const SizedBox(width: 3,),
                  GestureDetector(
                    onTap: (){
                      setState(() {

                        isAdd = isAdd? false: true;
                        if(isAdd){
                          widget.onAdd();
                        }
                      });
                    },
                      child: isAdd?const Icon(Icons.check_circle,color: Color(
                          0xff65aabc),size: 30,)
                          :const Icon(Icons.add_circle_rounded,color: Color(0xff7e7e7f),size: 30,))
                ],
              ),
            ],
          ),
        ),
      );}
    );
  }
}
