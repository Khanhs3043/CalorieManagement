import 'package:calopilot/models/myColor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class SearchItem2 extends StatefulWidget {
  String title;
  String info;

  final Function onTap;
  final Function onAdd;
  SearchItem2({super.key, required this.title, required this.info, required this.onTap, required this.onAdd});

  @override
  State<SearchItem2> createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem2> {
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
                  GestureDetector(
                      onTap: (){
                        setState(() {
                          widget.onAdd();
                          isAdd = isAdd? false: true;
                        });
                      },
                      child: isAdd?const Icon(Icons.check_circle,color: Color(
                          0xff65aabc),size: 40,)
                          :const Icon(Icons.add_circle_rounded,color: Color(0xff959596),size: 40,)),
                ],
              ),
            ),
          );}
    );
  }
}
