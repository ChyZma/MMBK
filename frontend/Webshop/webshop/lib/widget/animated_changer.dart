import 'package:flutter/material.dart';

import '../../app/theme/durations.dart';

class AnimatedChanger extends StatelessWidget {
  final Duration duration;
  final Curve curve;
  final Widget child;

  const AnimatedChanger({
    super.key,
    this.duration = Durations.mediumEnter,
    this.curve = Durations.standardCurve,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: duration,
      reverseDuration: duration,
      curve: curve,
      child: AnimatedSwitcher(
        switchInCurve: curve,
        switchOutCurve: curve,
        reverseDuration: duration,
        duration: duration,
        child: child,
      ),
    );
  }
}
