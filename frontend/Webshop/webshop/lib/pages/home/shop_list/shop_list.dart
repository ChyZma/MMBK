import 'package:flutter/material.dart';
import 'package:webshop/pages/home/shop_list/shop_list_item.dart';
import 'package:webshop/pages/home/shop_list/shop_model.dart';

import '../../../app/ioc.dart';
import '../../../app/theme/fonts.dart';
import '../../../app/theme/sizes.dart';
import '../../../widget/gaps.dart';

class ShopList extends StatefulWidget {
  const ShopList({super.key});

  @override
  State<ShopList> createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  late final _model = IoC.get<ShopModel>();
  late final _caffs = _model.caffs.value;
  @override
  Widget build(BuildContext context) {
    if (_caffs == null || _caffs!.isEmpty) {
      return const Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: Text(
            "Nincs elérhető CAFF",
            style: Fonts.big,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Sizes.medium, vertical: Sizes.medium),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _caffs!.length,
        itemBuilder: (context, index) {
          return ShopListItem(model: _caffs![index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Vgap.big();
        },
      ),
    );
  }
}
