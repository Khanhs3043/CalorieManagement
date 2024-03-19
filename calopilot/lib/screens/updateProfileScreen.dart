import 'package:flutter/material.dart';
class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  String selected = "Maintain weight";
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color(0xffe9e9e9),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Stack(
          children: [Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "GOAL",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color(0xff4d93d8),
                    ),
                  ),
                  const SizedBox(width: 20),
                  DropdownButton<String>(
                    focusColor: const Color(0xff707476),
                    underline: const SizedBox(),
                    style: const TextStyle(
                      color: Color(0xff707476),
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                    value: selected,
                    items: [
                      DropdownMenuItem<String>(
                        value: "Lost weight",
                        child: Text('Lost weight',),
                      ),
                      DropdownMenuItem<String>(
                        value: "Maintain weight",
                        child: Text('Maintain weight'),
                      ),
                      DropdownMenuItem<String>(
                        value: "Gain weight",
                        child: Text('Gain weight'),
                      ),
                    ],
                    onChanged: (val) {
                      setState(() {
                        selected = val!;
                      });
                    },
                  )
                ],
              ),
              const SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(
                    offset: Offset(0,4),
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.1)
                  )]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Kcal/day',style: TextStyle(fontSize: 20, color: Colors.grey,fontWeight: FontWeight.w500),),
                        Text('TDEE',style: TextStyle(fontSize:20, color: Colors.grey,fontWeight: FontWeight.w500),),
                        Text('BMR',style: TextStyle(fontSize: 20, color: Colors.grey,fontWeight: FontWeight.w500),),
                        Text('BMI',style: TextStyle(fontSize: 20, color: Colors.grey,fontWeight: FontWeight.w500),),
                      ],
                    ),
                    const SizedBox(width: 40,),
                    Column( crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('1795',style: TextStyle(fontSize: 20, color: Color(0xff4d93d8),fontWeight: FontWeight.w500)),
                        Text('1795',style: TextStyle(fontSize: 20, color: Color(0xff4d93d8),fontWeight: FontWeight.w500)),
                        Text('1306',style: TextStyle(fontSize: 20, color: Color(0xff4d93d8),fontWeight: FontWeight.w500)),
                        Text('18.1',style: TextStyle(fontSize: 20, color: Color(0xff4d93d8),fontWeight: FontWeight.w500))
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Height',style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.w500),),
                  Text('163 cm',style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.w500),)
                ],
              ),
               Container(height: 2,color: Colors.grey.shade400,),
              const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Weight',style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.w500),),
                  Text('48 kg',style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.w500),)
                ],
              ),
              Container(height: 2,color: Colors.grey.shade400,),
              const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Age',style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.w500),),
                  Text('18',style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.w500),)
                ],
              ),
              Container(height: 2,color: Colors.grey.shade400,),
              const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Gender',style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.w500),),
                  Text('male',style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.w500),)
                ],
              ),
              Container(height: 2,color: Colors.grey.shade400,),
              const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Activity level',style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.w500),),
                  Text('Low',style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.w500),)
                ],
              ),
              Container(height: 2,color: Colors.grey.shade400,),
              const SizedBox(height: 15,),
            ],
          ),
            Align(
              alignment: Alignment.bottomCenter,
                child: ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 12,horizontal: 60)),
                backgroundColor: MaterialStatePropertyAll(Color(0xff5e9ddb)),
                foregroundColor: MaterialStatePropertyAll(Colors.white)
              ),
              onPressed: () {  },
              child: Text('Continue',style: TextStyle(fontSize: 18),),))
          ]
        ),

      ),
    );
  }
}
