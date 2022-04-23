import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

bool? isGuest;

double screenWidth(context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(context) {
  return MediaQuery.of(context).size.height;
}

void swapPagesNoContext(context, view) {
  Navigator.push(context,MaterialPageRoute(builder: (context) => view),);
}

Future<dynamic> showCustomDialog(BuildContext context,
    { required String title,
      required String bodyText,
      required GestureTapCallback? onTap,
    }) async {
  showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(bodyText),
          actions: <Widget>[
            CupertinoDialogAction(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context)),
            CupertinoDialogAction(
                child: const Text("Ok"),
                onPressed: onTap)
          ],
        );
      }
  );
}

Future<dynamic> showCustomDialogNoCancel(BuildContext context,
    { required String title,
      required String bodyText,
      required GestureTapCallback? onTap,
    }) async {
  showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(bodyText),
          actions: <Widget>[
            CupertinoDialogAction(
                child: const Text("OK"),
                onPressed: onTap)
          ],
        );
      }
  );
}