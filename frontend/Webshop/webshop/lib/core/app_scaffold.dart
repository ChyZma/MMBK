import 'package:flutter/material.dart';
import 'package:webshop/app/theme/color_palette.dart';
import 'package:webshop/core/ui_handler.dart';

import '../widget/error_dialog.dart';
import 'display.dart';
import 'error_handler.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  final List<Widget> overlays;
  final UiHandler? uiHandler;
  final ErrorHandler? errorHandler;
  final PreferredSizeWidget? appBar;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Color backgroundColor;

  const AppScaffold({
    super.key,
    required this.body,
    this.bottomNavigationBar,
    this.overlays = const [],
    this.uiHandler,
    this.errorHandler,
    this.appBar,
    this.scaffoldKey,
    this.backgroundColor = ColorPalette.white,
  });

  @override
  Widget build(BuildContext context) {
    final eh = uiHandler?.errorHandler ?? errorHandler;
    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Scaffold(
            backgroundColor: backgroundColor,
            key: scaffoldKey,
            appBar: appBar,
            body: body,
            bottomNavigationBar: bottomNavigationBar,
          ),
          ...overlays,
          if (eh != null)
            Display.single(
              content: eh.current,
              condition: () => eh.current.value != null,
              builder: (_, __) {
                final e = eh.current.value!;
                return ErrorDialog(
                  title: e.title,
                  message: e.message,
                  primaryText: e.primaryText,
                  secondaryText: e.secondaryText,
                  onPrimaryTap: eh.primaryResolve,
                  onSecondaryTap: eh.secondaryResolve,
                );
              },
            ),
        ],
      ),
    );
  }
}
