import 'package:flutter/material.dart';

import 'color_palette.dart';

extension Fonts on TextStyle {
  static const family = 'Poppins';
  static const defaultColor = ColorPalette.black;
  static const weightNormal = FontWeight.w400;
  static const weightMedium = FontWeight.w500;
  static const weightBold = FontWeight.w700;

  static const TextStyle tiny = CaffShopTextStyle(12.0, 12.0);
  static const TextStyle small = CaffShopTextStyle(14.0, 18.0);
  static const TextStyle title = CaffShopTextStyle(28.0, 28.0);
  static const TextStyle smallTitle = CaffShopTextStyle(16.0, 20.0);
  static const TextStyle medium = CaffShopTextStyle(20.0, 20.0);
  static const TextStyle big = CaffShopTextStyle(22.00, 22.0);

  static const TextStyle h1 = CaffShopTextStyle(56.0, 64.0);
  static const TextStyle h2 = CaffShopTextStyle(40.0, 48.0);
  static const TextStyle h3 = CaffShopTextStyle(32.0, 42.0);
  static const TextStyle h4 = CaffShopTextStyle(26.0, 32.0);
  static const TextStyle h5 = CaffShopTextStyle(24.0, 25.0);
  static const TextStyle h6 = CaffShopTextStyle(20.0, 24.0);

  TextStyle get bold => copyWith(fontWeight: weightBold);
  TextStyle get white => copyWith(color: ColorPalette.white);
  TextStyle get wide => copyWith(letterSpacing: 2);
  TextStyle get mediumWeight => copyWith(fontWeight: weightMedium);
}

/// height = line-height / font-size
class CaffShopTextStyle extends TextStyle {
  const CaffShopTextStyle(
    double fontSize,
    double lineHeight,
  ) : super(
          fontFamily: Fonts.family,
          fontWeight: Fonts.weightNormal,
          color: Fonts.defaultColor,
          fontSize: fontSize,
          height: lineHeight / fontSize,
        );
}
