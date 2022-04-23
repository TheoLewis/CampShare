import 'package:campshare/utils/Globals.dart';
import 'package:campshare/views/PlatformMapView.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    super.initState();
    checkPermissions();
  }

  void checkPermissions() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: screenHeight(context) * 0.5),
                child: SizedBox(
                  width: screenWidth(context) * 0.8,
                  height: 75,
                  child: MaterialButton(
                    onPressed: () {},
                    child: Text("LOGIN", style: TextStyle(color: Colors.white)),
                    color: Colors.red,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: SizedBox(
                  width: screenWidth(context) * 0.8,
                  height: 75,
                  child: MaterialButton(
                    onPressed: () {},
                    child: Text("REGISTER", style: TextStyle(color: Colors.white)),
                    color: Colors.red,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: GestureDetector(
                  onTap: () {swapPagesNoContext(context, PlatformMapView(isGuest = true));},
                  child: Text("Continue as guest", style: TextStyle(color: Colors.red)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
