import 'package:campshare/utils/Globals.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'views/SplashView.dart';



void main() {
  createUserDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashView(),
    );
  }
}