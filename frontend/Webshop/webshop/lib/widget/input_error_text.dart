import 'package:flutter/material.dart';
import 'package:webshop/util/context_extension.dart';

import '../../app/theme/durations.dart';

class InputErrorText extends StatefulWidget {
  final String? text;
  final EdgeInsetsGeometry padding;

  const InputErrorText({
    Key? key,
    this.text,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  State<InputErrorText> createState() => _InputErrorTextState();
}

class _InputErrorTextState extends State<InputErrorText>
    with TickerProviderStateMixin {
  late String? text = widget.text;
  late final AnimationController controller;
  late final Animation<double> sizeAnimation, fadeAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Durations.longEnter,
      vsync: this,
    );
    sizeAnimation = CurvedAnimation(
      parent: controller,
      curve: Durations.standardCurve,
    );
    fadeAnimation = CurvedAnimation(
      parent: controller,
      curve: Durations.standardCurve,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant InputErrorText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.text == null) {
      controller.reverse();
    } else {
      text = widget.text;
      controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = context.theme.inputDecorationTheme.errorStyle;
    return SizeTransition(
      sizeFactor: sizeAnimation,
      axis: Axis.vertical,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: Padding(
          padding: widget.padding,
          child: Text(
            text ?? '',
            style: style,
          ),
        ),
      ),
    );
  }
}
