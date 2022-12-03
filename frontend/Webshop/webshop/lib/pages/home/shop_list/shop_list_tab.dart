import 'package:flutter/material.dart';
import 'package:webshop/pages/home/shop_list/shop_list.dart';

import '../../../widget/common.dart';
import '../home_screen_header.dart';

class ShopListTab extends StatefulWidget {
  const ShopListTab({super.key});

  @override
  State<StatefulWidget> createState() => _BoatListState();
}

class _BoatListState extends State<ShopListTab> {
  final _controller = ScrollController();
  late GlobalKey _key0;

  @override
  void initState() {
    super.initState();
    _key0 = GlobalKey();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: SingleChildScrollView(
            controller: _controller,
            child: Column(
              children: const [
                ShopList(),
              ],
            ),
          ),
        ),
        topPositioned(
          child: HomeScreenHeader(
            title: "CAFF Shop",
            controller: _controller,
            observedWidgetKey: _key0,
          ),
        ),
      ],
    );
  }
}
