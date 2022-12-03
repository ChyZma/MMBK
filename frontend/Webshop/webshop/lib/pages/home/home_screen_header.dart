import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:webshop/util/context_extension.dart';

import '../../app/theme/assets.dart';
import '../../app/theme/color_palette.dart';
import '../../app/theme/durations.dart';
import '../../app/theme/fonts.dart';
import '../../widget/gaps.dart';

class HomeScreenHeader extends StatefulWidget {
  final String? title;
  final ScrollController controller;
  final GlobalKey observedWidgetKey;

  const HomeScreenHeader({
    super.key,
    required this.title,
    required this.controller,
    required this.observedWidgetKey,
  });

  @override
  State<HomeScreenHeader> createState() => _HomeScreenHeaderState();
}

class _HomeScreenHeaderState extends State<HomeScreenHeader> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const duration = Durations.longExit;
    const curve = Durations.standardCurve;
    const color = ColorPalette.white;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: ColorPalette.black,
          height: context.statusBarHeight,
        ),
        AnimatedContainer(
          curve: curve,
          duration: duration,
          height: 100 - context.statusBarHeight,
          decoration: BoxDecoration(
            color: _visible ? color : color.withOpacity(0),
            boxShadow: [
              BoxShadow(
                color: _visible
                    ? ColorPalette.shadowLight
                    : ColorPalette.shadowLight.withOpacity(0),
                blurRadius: 4,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Hgap.medium(),
              AnimatedOpacity(
                opacity: _visible ? 1.0 : 0.0,
                duration: duration,
                curve: curve,
                child: const CircleAvatar(
                  radius: 17.5,
                  backgroundImage: Assets.iconBasket,
                ),
              ),
              Hgap.tiny(),
              Expanded(
                child: AnimatedOpacity(
                  opacity: _visible ? 1.0 : 0.0,
                  duration: duration,
                  curve: curve,
                  child: Text(
                    widget.title ?? '',
                    style: Fonts.medium,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Hgap.tiny(),
              const Hgap(48),
              Hgap.tiny(),
            ],
          ),
        ),
      ],
    );
  }

  void _onScroll() {
    final ratio = _calculateVisibilityRatioOfObservedWidget();
    if (_visible && ratio < 0.6) {
      setState(() {
        _visible = false;
      });
    } else if (!_visible && ratio > 0.7) {
      setState(() {
        _visible = true;
      });
    }
  }

  double _calculateVisibilityRatioOfObservedWidget() {
    double observedWidgetTopPosition = 0.0;
    double observedWidgetHeight = 1.0;

    final renderObject = widget.observedWidgetKey.currentContext
        ?.findRenderObject() as RenderBox?;
    final viewport = RenderAbstractViewport.of(renderObject);

    if (renderObject != null && viewport != null && renderObject.hasSize) {
      observedWidgetTopPosition =
          viewport.getOffsetToReveal(renderObject, 0.0).offset;
      observedWidgetHeight = renderObject.size.height;
    }

    // On iOS offset can be negative duo to bounce physics, so we need to clamp
    final relativeOffset = widget.controller.offset - observedWidgetTopPosition;
    return (relativeOffset / observedWidgetHeight).clamp(0, 1);
  }
}
