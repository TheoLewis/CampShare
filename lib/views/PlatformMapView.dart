import 'package:flutter/material.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:vibration/vibration.dart';

class PlatformMapView extends StatefulWidget {
  bool? isGuest;
  PlatformMapView(this.isGuest);

  @override
  State<PlatformMapView> createState() => _PlatformMapViewState();
}

class _PlatformMapViewState extends State<PlatformMapView> {

  @override
  void initState() {
    super.initState();
  }

  void createMarker(tapPos) {
    Vibration.vibrate(duration: 500);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: PlatformMap(
            initialCameraPosition: CameraPosition(target: LatLng(-37.971237,144.4926947), zoom: 5),
            onLongPress: (tapPos) {},
          ),
        ),
      )
    );
  }
}
