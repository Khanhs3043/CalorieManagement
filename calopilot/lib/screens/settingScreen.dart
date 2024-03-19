import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calopilot/models/myColor.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Provider.of<MyUI>(context).appBarColor,
      ),
      body: Consumer<MyUI>(
        builder: (context, ui, child) {
          return Container(
            color: ui.isDark ? ui.color1 : ui.color2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text(
                        'Dark Mode',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ui.textColor,
                        ),
                      ),
                      Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Colors.grey[400]!,
                            width: 2.0,
                          ),
                        ),
                        child: Switch(
                          value: ui.isDark,
                          onChanged: (value) {
                            ui.switchTheme();
                          },
                        ),
                      ),
                    ],
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
