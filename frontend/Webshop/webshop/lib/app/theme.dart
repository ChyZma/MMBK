import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webshop/app/theme/color_palette.dart';
import 'package:webshop/app/theme/fonts.dart';

import '../service/platform_service.dart';

class AppTheme {
  static ThemeData get materialTheme => ThemeData(
        primaryColor: ColorPalette.black,
        disabledColor: ColorPalette.gray40,
        scaffoldBackgroundColor: ColorPalette.white,
        canvasColor: ColorPalette.white,
        errorColor: ColorPalette.error,
        dialogTheme: const DialogTheme(
          backgroundColor: ColorPalette.white,
          shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
              ),
              side: BorderSide(color: ColorPalette.gray10, width: 1)),
        ),
        timePickerTheme: const TimePickerThemeData(
          shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
              ),
              side: BorderSide(color: ColorPalette.gray10, width: 1)),
        ),
        inputDecorationTheme: InputDecorationTheme(
          errorMaxLines: 3,
          errorStyle: Fonts.small.copyWith(
            color: ColorPalette.error,
          ),
          labelStyle: Fonts.medium,
          prefixStyle: Fonts.medium.copyWith(
            color: ColorPalette.gray20,
          ),
          hintStyle: Fonts.medium.copyWith(
            color: ColorPalette.gray20,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
        textTheme: const TextTheme(
          displayLarge: Fonts.h1,
          displayMedium: Fonts.h2,
          displaySmall: Fonts.h3,
          headlineMedium: Fonts.h4,
          headlineSmall: Fonts.h5,
          titleLarge: Fonts.h5,
          titleMedium: Fonts.h6,
          titleSmall: Fonts.smallTitle,
          bodyLarge: Fonts.big,
          bodyMedium: Fonts.medium,
          bodySmall: Fonts.small,
          labelLarge: Fonts.small,
          labelSmall: Fonts.tiny,
        ),
      );

  AppTheme._();

  static SystemUiOverlayStyle getSystemTheme({
    Brightness brightness = Brightness.dark,
    Color systemNavigationBarColor = ColorPalette.transparent,
  }) {
    Color navTrayColor;
    Brightness b;
    // NOTE: on android/ios light & dark behaves differently
    if (PlatformService.isIos) {
      navTrayColor = ColorPalette.transparent;
      if (brightness == Brightness.light) {
        b = Brightness.dark;
      } else {
        b = Brightness.light;
      }
    } else {
      b = brightness;
      navTrayColor = systemNavigationBarColor;
    }

    return SystemUiOverlayStyle(
      statusBarColor: ColorPalette.transparent,
      statusBarBrightness: b,
      statusBarIconBrightness: b,
      systemNavigationBarIconBrightness: b,
      systemNavigationBarColor: navTrayColor,
    );
  }
}
