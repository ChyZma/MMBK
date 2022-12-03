import 'package:flutter/material.dart';

import '../app/theme/durations.dart';
import 'content.dart';

typedef DisplayCondition = bool Function();

class Display<T> extends StatelessWidget {
  final Listenable listenable;
  final TransitionBuilder builder;
  final DisplayCondition? condition;
  final Widget? child;

  final Duration enterDuration, exitDuration;

  const Display({
    super.key,
    required this.listenable,
    required this.builder,
    this.condition,
    this.enterDuration = Durations.longEnter,
    this.exitDuration = Durations.longExit,
    this.child,
  });

  factory Display.multi({
    required List<Content> contents,
    required TransitionBuilder builder,
    DisplayCondition? condition,
  }) {
    return Display(
      listenable: Listenable.merge(contents.map((c) => c.notifier).toList()),
      condition: condition,
      builder: builder,
    );
  }

  factory Display.single({
    required Content content,
    required TransitionBuilder builder,
    DisplayCondition? condition,
  }) {
    return Display(
      listenable: content.notifier,
      condition: condition,
      builder: builder,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: listenable,
      builder: (context, child) {
        final result = condition?.call() ?? true;
        final widget = result ? builder(context, child) : const SizedBox();
        return AnimatedSwitcher(
          duration: enterDuration,
          reverseDuration: exitDuration,
          switchInCurve: Durations.standardCurve,
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: widget,
        );
      },
      child: child,
    );
  }
}
