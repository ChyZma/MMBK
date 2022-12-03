import 'package:flutter/material.dart';

Positioned topPositioned({
  required Widget child,
  double top = 0,
  double left = 0,
  double right = 0,
}) {
  return Positioned(
    left: left,
    right: right,
    top: top,
    child: child,
  );
}

Positioned bottomPositioned({
  required Widget child,
  double bottom = 0,
  double left = 0,
  double right = 0,
}) {
  return Positioned(
    left: left,
    right: right,
    bottom: bottom,
    child: child,
  );
}
