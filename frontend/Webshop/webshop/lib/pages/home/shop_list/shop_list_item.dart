import 'package:flutter/material.dart';

import '../../../app/ioc.dart';
import '../../../models/caff.dart';
import '../../../routing/app_route.dart';

class ShopListItem extends StatelessWidget {
  final Caff model;

  const ShopListItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppRoute route = AppRoute.caffInfo(model);
        IoC.router.push(route);
      },
      child: Container(
        color: Colors.yellow,
        height: 260,
      ),
    );
  }
}
