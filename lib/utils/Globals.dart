import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'dart:ui' as ui;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
late Future<Database> database;

bool? isGuest;
bool? isVerified;

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

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
}

Future<BitmapDescriptor> changeIcon(image, size) async {
  final Uint8List markerIcon = await getBytesFromAsset(image, size);
  return BitmapDescriptor.fromBytes(markerIcon);
}

void createUserDb() async {
  WidgetsFlutterBinding.ensureInitialized();
  database = openDatabase(
    join(await getDatabasesPath(), 'userPreferences.db'),
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE campMarkers(lat REAL, long REAL)'
      );
    },
    version: 1,
  );
  print('we are here');
}