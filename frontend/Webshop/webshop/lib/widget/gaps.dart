import 'package:flutter/material.dart';
import 'package:webshop/util/context_extension.dart';

import '../app/theme/sizes.dart';

class Vgap extends StatelessWidget {
  final double size;

  const Vgap([this.size = Sizes.medium]);

  factory Vgap.tiny() => const Vgap(Sizes.tiny);
  factory Vgap.small() => const Vgap(Sizes.small);
  factory Vgap.medium() => const Vgap(Sizes.medium);
  factory Vgap.large() => const Vgap(Sizes.large);
  factory Vgap.big() => const Vgap(Sizes.big);
  factory Vgap.huge() => const Vgap(Sizes.huge);
  factory Vgap.giant() => const Vgap(Sizes.giant);
  factory Vgap.page() => const Vgap(Sizes.pageMargin);
  factory Vgap.appBar() => const Vgap(kToolbarHeight);
  factory Vgap.systemNavbar(BuildContext context) {
    return Vgap(context.bottomNavBarHeight);
  }
  factory Vgap.systemStatusBar(BuildContext context) {
    return Vgap(context.statusBarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size);
  }
}

class Hgap extends StatelessWidget {
  final double size;

  const Hgap([this.size = Sizes.medium]);

  factory Hgap.tiny() => const Hgap(Sizes.tiny);
  factory Hgap.small() => const Hgap(Sizes.small);
  factory Hgap.medium() => const Hgap(Sizes.medium);
  factory Hgap.big() => const Hgap(Sizes.big);
  factory Hgap.page() => const Hgap(Sizes.pageMargin);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size);
  }
}
