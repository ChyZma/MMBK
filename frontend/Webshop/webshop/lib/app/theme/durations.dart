import 'package:flutter/material.dart';

class Durations {
  static const short = Duration(milliseconds: 100);
  static const mediumEnter = Duration(milliseconds: 250);
  static const mediumExit = Duration(milliseconds: 200);
  static const longEnter = Duration(milliseconds: 300);
  static const longExit = Duration(milliseconds: 250);

  static const standardCurve = Curves.fastOutSlowIn;

  Durations._();
}
