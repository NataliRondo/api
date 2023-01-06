import 'package:flutter/material.dart';

Future showMyDialog(BuildContext context, String titulo, String mensaje) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text(titulo)),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(mensaje),
                
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }