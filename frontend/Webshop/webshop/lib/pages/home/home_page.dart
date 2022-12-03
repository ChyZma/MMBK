import 'package:flutter/material.dart';
import 'package:webshop/pages/home/profile/profile_model.dart';
import 'package:webshop/pages/home/profile/profile_tab.dart';
import 'package:webshop/pages/home/shop_list/shop_list_tab.dart';

import '../../app/ioc.dart';
import '../../app/theme/assets.dart';
import '../../app/theme/color_palette.dart';
import '../../widget/system_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SystemStyle.light(
      systemNavigationBarColor: ColorPalette.transparent,
      child: Scaffold(
        backgroundColor: ColorPalette.white,
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
              border:
                  Border(top: BorderSide(color: ColorPalette.gray10, width: 1)),
              color: ColorPalette.white),
          child: TabBar(
            controller: _controller,
            indicatorColor: ColorPalette.orange,
            indicatorSize: TabBarIndicatorSize.label,
            labelPadding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            indicatorPadding: const EdgeInsets.only(bottom: 67),
            indicatorWeight: 3,
            labelColor: ColorPalette.black,
            unselectedLabelColor: ColorPalette.gray20,
            tabs: [
              Tab(
                icon: TabContent(
                    selected: _controller.index == 0, image: Assets.iconBasket),
              ),
              Tab(
                  icon: TabContent(
                selected: _controller.index == 1,
                image: Assets.iconBasket,
              )),
              Tab(
                  icon: TabContent(
                selected: _controller.index == 2,
                image: Assets.iconBasket,
              )),
            ],
          ),
        ),
        body: TabBarView(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const ShopListTab(key: PageStorageKey('0')),
            const ShopListTab(key: PageStorageKey('1')),
            ProfileTab(
                key: const PageStorageKey('2'), model: IoC.get<ProfileModel>()),
          ],
        ),
      ),
    );
  }
}

class TabContent extends StatelessWidget {
  final bool selected;
  final ImageProvider image;

  const TabContent({super.key, required this.selected, required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 31,
      height: 24,
      child: Image(
        color: selected ? ColorPalette.black : ColorPalette.gray20,
        image: image,
      ),
    );
  }
}