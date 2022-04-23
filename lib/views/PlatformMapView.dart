import 'dart:async';

import 'package:campshare/utils/Globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:async/async.dart';

class PlatformMapView extends StatefulWidget {
  bool? isGuest;
  PlatformMapView(this.isGuest);

  @override
  State<PlatformMapView> createState() => _PlatformMapViewState();
}

final PanelController panelViewController = PanelController();

class _PlatformMapViewState extends State<PlatformMapView> {

  bool panelVisible = false;
  Set<Marker> markers = {};
  double handleWidth = 90;
  double handleHeight = 7;


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
        setState(() {
          panelVisible = true;
        });
      }
    );
    setState(() {
      markers.add(marker);
    });
  }

  Column slideUpPanel() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 15, left: screenWidth(context) / 2 - handleWidth / 1.3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  width: handleWidth,
                  height: handleHeight,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.all(Radius.circular(12.0))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screenWidth(context) / 2 - handleWidth),
                child: GestureDetector(
                  onTap: () {setState(() {
                    panelVisible = false;
                  });},
                  child: Icon(Icons.close, color: Colors.grey[300])
                )
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 15, left: 20),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text("Wulleringa Falls", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
          )
        ),
        Padding(
          padding: EdgeInsets.only(top: 5, left: 20),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text("72 Wulleringa Drive, Sydney, 1440"),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, left: screenWidth(context) * 0.05, right: screenWidth(context) * 0.05),
          child: Container(
            width: screenWidth(context) * 0.90,
            height: 120,
            child: Row(
              children: [
                Container(
                  width: screenWidth(context) / 3 - 25,
                  height: 120,
                  child: Image.asset('assets/Images/download.jpg'),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Container(
                    width: screenWidth(context) / 3 - 25,
                    height: 120,
                    child: Image.asset('assets/Images/download.jpg'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Container(
                    width: screenWidth(context) / 3 - 25,
                    height: 120,
                    child: Image.asset('assets/Images/addImage.png'),
                  ),
                )
              ],
            ),
          ),
        ),
        Text("4"),
        Text("5"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: PlatformMap(
              initialCameraPosition: CameraPosition(target: LatLng(-37.971237,144.4926947), zoom: 5),
              zoomControlsEnabled: false,
              onLongPress: (tapPos) {mapLongPress(tapPos);},
              markers: markers,
            ),
          ),
          Visibility(
            visible: panelVisible,
            child: SlidingUpPanel(
              panel: slideUpPanel(),
              controller: panelViewController,
              minHeight: 300,
              maxHeight: 650,
            ),
          )
        ],
      )
    );
  }
}


