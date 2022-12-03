import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AnimatedPageBuilder extends CustomTransitionPage {
  final Widget Function(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) transitionBuilder;

  const AnimatedPageBuilder(child, {super.key, required this.transitionBuilder})
      : super(child: child, transitionsBuilder: transitionBuilder);

  factory AnimatedPageBuilder.left({Key? key, required child}) {
    return AnimatedPageBuilder(child,
        transitionBuilder: _builder(const Offset(1.0, 0.0)));
  }

  factory AnimatedPageBuilder.up({Key? key, required child}) {
    return AnimatedPageBuilder(child,
        transitionBuilder: _builder(const Offset(0.0, 1.0)));
  }
}

Widget Function(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) _builder(Offset offset) {
  return (context, animation, secondaryAnimation, child) {
    const end = Offset.zero;
    const curve = Curves.ease;

    var tween = Tween(begin: offset, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  };
}
