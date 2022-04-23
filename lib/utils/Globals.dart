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