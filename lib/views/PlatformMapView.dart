import 'dart:async';

import 'package:campshare/utils/Globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PlatformMapView extends StatefulWidget {
  bool? isGuest;
  PlatformMapView(this.isGuest);

  @override
  State<PlatformMapView> createState() => _PlatformMapViewState();
}

final PanelController panelViewController = PanelController();

class _PlatformMapViewState extends State<PlatformMapView> {

  TextEditingController locationNameController = TextEditingController();

  bool panelVisible = false;
  bool toiletsAvailable = true;
  bool showersAvailable = true;
  bool waterAvailable = true;
  bool disabledAvailable = true;
  bool noUtilities = true;
  Set<Marker> markers = {};
  double handleWidth = 90;
  double handleHeight = 7;

  double? locationLat;
  double? locationLong;

  @override
  void initState() {
    super.initState();
    setState(() {
      if(!showersAvailable && !toiletsAvailable && !waterAvailable && !disabledAvailable) {
        noUtilities = true;
      } else {
        noUtilities = false;
      }
    });
  }

  void mapLongPress(LatLng tapPos) {
    Vibrate.feedback(FeedbackType.selection);
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Save Location?"),
          content: Column(
            children: [
              Center(
                child: TextFormField(
                  controller: locationNameController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter Location Name',
                  ),
                ),
              )
            ],
          ),
          actions: <Widget>[
            MaterialButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context)),
            MaterialButton(
                child: const Text("Ok"),
                onPressed: () { createMarker(tapPos, locationNameController.value.text); Navigator.pop(context); })
          ],
        );
      }
    );
  }

  void createMarker(LatLng tapPos, locationName) async {
    if(markers.length < 3) {
      Marker marker = Marker(
          markerId: MarkerId("Location $tapPos"),
          position: LatLng(tapPos.latitude, tapPos.longitude),
          icon: await changeIcon('assets/Images/campgroundImage.png', 64),
          onTap: () {
            setState(() {
              panelVisible = true;
            });
          }
      );
      setState(() {
        markers.add(marker);
      });
    } else {
      Fluttertoast.showToast(msg: "You have exceeded the listing limit.\n View our plans for more listings.", toastLength: Toast.LENGTH_LONG);
    }
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
                  padding: EdgeInsets.only(left: screenWidth(context) / 2 - handleWidth - 10),
                  child: GestureDetector(
                      onTap: () {setState(() {

                      });},
                      child: Icon(Icons.edit, color: Colors.grey[300])
                  )
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
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
        Row(
          children: [
            Padding(
                padding: EdgeInsets.only(top: 15, left: 20),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(locationNameController.value.text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
                )
            ),
            Visibility(
              visible: isVerified ?? false,
              child: Padding(
                  padding: const EdgeInsets.only(left: 5, top: 15),
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: GestureDetector(
                      onLongPress: () {Fluttertoast.showToast(msg: "Verified Campsite", backgroundColor: Color(0xff72FF59));},
                      //child: Image.asset('assets/Images/verifiedBadge.png'),
                    ),
                  )
              )
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 5, left: 20),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text("$locationLat, $locationLong"),
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
        Padding(
          padding: EdgeInsets.only(top: 10, left: 20),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text("Utilities", style: TextStyle(fontWeight: FontWeight.bold)),
          )
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, left: 20),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Visibility(
                  visible: waterAvailable,
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset('assets/Images/waterUtility.png'),
                  ),
                ),
                Visibility(
                  visible: showersAvailable,
                  child: Padding(
                    padding: EdgeInsets.only(left: 7.5),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.asset('assets/Images/showerUtility.png'),
                    ),
                  ),
                ),
                Visibility(
                  visible: toiletsAvailable,
                  child: Padding(
                    padding: EdgeInsets.only(left: 7.5),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.asset('assets/Images/bathroomUtility.png'),
                    ),
                  ),
                ),
                Visibility(
                  visible: disabledAvailable,
                  child: Padding(
                    padding: EdgeInsets.only(left: 7.5),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.asset('assets/Images/disabilityUtility.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
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
              mapType: MapType.normal,
              zoomControlsEnabled: false,
              onLongPress: (tapPos) {mapLongPress(tapPos); locationLat = tapPos.latitude; locationLong = tapPos.longitude;},
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


