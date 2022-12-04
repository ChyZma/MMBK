import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  MediaQueryData get media => MediaQuery.of(this);

  double get screenWidth => media.size.width;
  double get statusBarHeight => media.padding.top;
  double get bottomNavBarHeight => media.viewPadding.bottom;
}
