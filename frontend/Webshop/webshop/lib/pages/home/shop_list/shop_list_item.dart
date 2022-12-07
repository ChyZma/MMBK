import 'package:flutter/material.dart';
import 'package:webshop/widget/gaps.dart';

import '../../../app/ioc.dart';
import '../../../app/theme/color_palette.dart';
import '../../../app/theme/fonts.dart';
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
        decoration: BoxDecoration(
          color: ColorPalette.gray10,
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
              ),
              const Vgap(8.0),
              Row(
                children: [
                  for (var item in model.tags) ...[
                    Text(
                      item,
                      style: Fonts.tiny,
                    ),
                    const Hgap(8.0),
                  ]
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
