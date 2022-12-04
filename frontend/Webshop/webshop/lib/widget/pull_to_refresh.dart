import 'package:flutter/material.dart';

import '../app/theme/color_palette.dart';

class PullToRefresh extends StatelessWidget {
  final Widget child;
  final RefreshCallback onRefresh;
  final double displacement, edgeOffset;

  const PullToRefresh({
    Key? key,
    required this.onRefresh,
    required this.child,
    this.displacement = 40.0,
    this.edgeOffset = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: ColorPalette.blue,
      backgroundColor: ColorPalette.white,
      displacement: displacement,
      edgeOffset: edgeOffset,
      strokeWidth: 2,
      child: child,
    );
  }
}
