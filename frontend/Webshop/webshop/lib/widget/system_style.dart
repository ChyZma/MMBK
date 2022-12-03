import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app/theme.dart';
import '../app/theme/color_palette.dart';

class SystemStyle extends StatelessWidget {
  final SystemUiOverlayStyle style;
  final Widget child;

  const SystemStyle({
    Key? key,
    required this.style,
    required this.child,
  }) : super(key: key);

  /// White text on dark background
  factory SystemStyle.light({
    required Widget child,
    Color systemNavigationBarColor = ColorPalette.white,
  }) {
    return SystemStyle(
      style: AppTheme.getSystemTheme(
        brightness: Brightness.light,
        systemNavigationBarColor: systemNavigationBarColor,
      ),
      child: child,
    );
  }

  /// Dark text on light background
  factory SystemStyle.dark({
    required Widget child,
    Color systemNavigationBarColor = ColorPalette.white,
  }) {
    return SystemStyle(
      style: AppTheme.getSystemTheme(
        brightness: Brightness.dark,
        systemNavigationBarColor: systemNavigationBarColor,
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: style,
      child: child,
    );
  }
}
