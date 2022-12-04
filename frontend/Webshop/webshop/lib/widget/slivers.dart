import 'dart:math' as math;

import 'package:flutter/material.dart';

class SliverChild extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const SliverChild({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    final content = SliverChildren(children: [child]);
    return padding == null
        ? content
        : SliverPadding(padding: padding!, sliver: content);
  }
}

class SliverChildren extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets? padding;

  const SliverChildren({
    super.key,
    this.padding,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    var content = SliverList(delegate: SliverChildListDelegate(children));
    return padding == null
        ? content
        : SliverPadding(padding: padding!, sliver: content);
  }
}

class SliverHeader extends StatelessWidget {
  final bool pinned;
  final double minHeight, maxHeight;
  final Widget? child;

  const SliverHeader({
    Key? key,
    this.pinned = false,
    this.minHeight = kToolbarHeight,
    this.maxHeight = kToolbarHeight,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: pinned,
      delegate: _SliverHeaderDelegate(
        minHeight: minHeight,
        maxHeight: maxHeight,
        child: child,
      ),
    );
  }
}

class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget? child;

  _SliverHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverHeaderDelegate old) {
    return maxHeight != old.maxHeight ||
        minHeight != old.minHeight ||
        child != old.child;
  }
}

class SliverFill extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry padding;

  const SliverFill({
    super.key,
    this.child,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
