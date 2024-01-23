import 'package:calopilot/models/myColor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyUI>(
      builder: (BuildContext context, MyUI ui, Widget? child) {
      return Scaffold(
        backgroundColor: ui.color2,
        body: Stack(
          children: [
            Container(
              height: 230,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ui.color3,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),

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
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(children: [
                          Text('Eaten',style: TextStyle(
                            fontSize: 16,
                            color: ui.color4
                          ),),
                          Text('350',style: TextStyle(
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
                            children: [
                              Container(height: 100,width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: ui.color2
                              ),)
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(children: [
                          Text('Eaten',style: TextStyle(
                              fontSize: 16,
                              color: ui.color4
                          ),),
                          Text('350',style: TextStyle(
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
            Column(
            children: [

            ],
          ),]
        ),
      );},
    );
  }
}
