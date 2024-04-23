import 'package:flutter/material.dart';

enum AlertAction { cancel, ok }

class DialogComponents {
  static loaderShow(BuildContext context) {
    return showDialog(
      context: context,
      useRootNavigator: false,
      barrierColor: null,
      // barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(0),
          content: Builder(
            builder: (context) {
              return const Center(child: CircularProgressIndicator());
            },
          ),
        );
      },
    );
  }

  static loaderStop(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  static snackBar(BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  static confirmDialog(BuildContext context, String message) {
    return showDialog<AlertAction>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm"),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(AlertAction.cancel);
              },
              child: Text("Cancel")),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(AlertAction.ok);
              },
              child: Text("Ok"))
        ],
      ),
    );
  }
}
