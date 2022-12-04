import 'package:flutter/material.dart';
import 'package:webshop/util/context_extension.dart';

import '../app/theme/color_palette.dart';

class CircularProgress extends StatelessWidget {
  final double size, stroke;
  final Color? color;

  const CircularProgress({
    Key? key,
    this.size = 16,
    this.stroke = 4,
    this.color = ColorPalette.black,
  }) : super(key: key);

  factory CircularProgress.small({Color? color}) {
    return CircularProgress(size: 20, stroke: 2, color: color);
  }

  factory CircularProgress.big({Color? color}) {
    return CircularProgress(size: 44, stroke: 4, color: color);
  }

  @override
  Widget build(BuildContext context) {
    final progressColor = color ?? context.theme.indicatorColor;
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(progressColor),
        strokeWidth: stroke,
      ),
    );
  }
}
