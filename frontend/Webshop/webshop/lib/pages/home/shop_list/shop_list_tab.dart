import 'package:flutter/material.dart';
import 'package:webshop/app/theme/color_palette.dart';
import 'package:webshop/app/theme/fonts.dart';
import 'package:webshop/pages/home/shop_list/shop_list.dart';
import 'package:webshop/pages/home/shop_list/shop_model.dart';

class ShopListTab extends StatelessWidget {
  final ShopModel model;

  const ShopListTab({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Caff Shop',
              style: Fonts.h3,
            ),
          ),
          backgroundColor: ColorPalette.gray10,
        ),
        body: ShopList(model: model));
  }
}
