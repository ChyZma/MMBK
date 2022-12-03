import 'package:flutter/material.dart';
import 'package:webshop/widget/system_style.dart';

import '../app/theme/color_palette.dart';
import '../app/theme/sizes.dart';

Future<T?> showThemedDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool useRootNavigator = true,
  bool useDesignWrapper = true,
}) {
  // NOTE: PageRouteBuilder is needed instead of DialogRoute to be able
  // to change system statusbar/navigationbar colors.
  return Navigator.of(context, rootNavigator: useRootNavigator).push<T>(
    PageRouteBuilder(
      opaque: false,
      barrierDismissible: true,
      barrierColor: ColorPalette.gray40,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        Widget child;
        if (useDesignWrapper) {
          child = Center(
            child: Dialog(
              child: Padding(
                padding: const EdgeInsets.all(Sizes.medium),
                child: Material(
                  color: ColorPalette.transparent,
                  child: builder(context),
                ),
              ),
            ),
          );
        } else {
          child = builder(context);
        }

        return SystemStyle.light(
          systemNavigationBarColor: ColorPalette.transparent,
          child: child,
        );
      },
    ),
  );
}
