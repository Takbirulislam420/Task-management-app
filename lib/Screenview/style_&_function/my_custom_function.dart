import 'package:flutter/material.dart';

void customAlertFunction({
  required BuildContext context,
  required String title,
  required String message,
  required VoidCallback onOk,
  required VoidCallback onCancel,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
              onOk(); // Call the OK callback
            },
          ),
          TextButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
              onCancel(); // Call the Cancel callback
            },
          ),
        ],
      );
    },
  );
}
