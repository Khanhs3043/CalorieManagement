import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils{
  static void showAlertDialog(BuildContext context, String message,Function onOK) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Notify"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                onOK;
              },
              child: Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
  
  static void showSnackbar(BuildContext context, String message){
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2), // Thời gian hiển thị Snackbar
        ),
      );
    }
}
