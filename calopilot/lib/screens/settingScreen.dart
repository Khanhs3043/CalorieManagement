import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calopilot/models/myColor.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Provider.of<MyUI>(context).color2,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('Settings'),
        backgroundColor: Provider.of<MyUI>(context).appBarColor,
      ),
      body: Consumer<MyUI>(
        builder: (context, ui, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 60,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ui.color1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Darkmode",
                        style: TextStyle(
                            fontSize: 17, color:ui.color4),
                      ),
                      Switch(
                          value: ui.isDark,
                          onChanged: (isDark) {
                            ui.switchTheme();
                          })
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 60,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ui.color1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Language",
                        style: TextStyle(
                            fontSize: 17, color: ui.color4),
                      ),
                      Switch(
                          value: false,
                          onChanged: (_) {

                          })
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('You want to sign out ?'),
                            actions: [
                              TextButton(
                                  onPressed: () {

                                  },
                                  child: Text('OK')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel'))
                            ],
                          );
                        });
                  },
                  child: Container(
                    height: 60,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: ui.color1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Log Out",
                          style: TextStyle(
                              fontSize: 17, color: ui.color4),
                        ),
                        const Icon(
                          Icons.power_settings_new_outlined,
                          color: Colors.red,
                          size: 30,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
