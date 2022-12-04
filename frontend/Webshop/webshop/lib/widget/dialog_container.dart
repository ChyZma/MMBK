import 'package:flutter/material.dart';
import 'package:webshop/widget/system_style.dart';

import '../app/theme/color_palette.dart';
import '../app/theme/sizes.dart';

class DialogContainer extends StatelessWidget {
  final Widget child;
  final bool ignoreTouches, barrierDismissAllowed;
  final VoidCallback? onCancel;

  const DialogContainer({
    Key? key,
    required this.child,
    this.ignoreTouches = false,
    this.barrierDismissAllowed = true,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SystemStyle.light(
      systemNavigationBarColor: ColorPalette.transparent,
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: GestureDetector(
          onTap: () {
            if (barrierDismissAllowed) {
              onCancel?.call();
            }
          },
          child: IgnorePointer(
            ignoring: ignoreTouches,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: ColorPalette.gray20.withOpacity(0.8),
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(Sizes.big),
                  padding: const EdgeInsets.all(Sizes.big),
                  decoration: const BoxDecoration(
                    color: ColorPalette.white,
                  ),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
