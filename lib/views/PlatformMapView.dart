import 'package:campshare/utils/Globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';

class PlatformMapView extends StatefulWidget {
  bool? isGuest;
  PlatformMapView(this.isGuest);

  @override
  State<PlatformMapView> createState() => _PlatformMapViewState();
}

class _PlatformMapViewState extends State<PlatformMapView> {

  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
  }

  void mapLongPress(LatLng tapPos) {
    Vibrate.feedback(FeedbackType.selection);
    showCustomDialog(context, title: "Save location?", bodyText: "Would you like to save this location?", onTap: () {createMarker(tapPos); Navigator.pop(context);});
  }

  void createMarker(LatLng tapPos) {
    Marker marker = Marker(
      markerId: MarkerId("Location $tapPos"),
      position: LatLng(tapPos.latitude, tapPos.longitude),
      icon: BitmapDescriptor.defaultMarker,
      onTap: () {
        Fluttertoast.showToast(
            msg: "This is Center Short Toast",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    );
    setState(() {
      markers.add(marker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PlatformMap(
          initialCameraPosition: CameraPosition(target: LatLng(-37.971237,144.4926947), zoom: 5),
          onLongPress: (tapPos) {mapLongPress(tapPos);},
          markers: markers,
        ),
      ),
    );
  }
}
