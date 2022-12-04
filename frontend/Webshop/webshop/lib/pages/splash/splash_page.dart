import 'package:flutter/material.dart';
import 'package:webshop/pages/splash/splash_model.dart';
import 'package:webshop/widget/common.dart';

import '../../app/ioc.dart';
import '../../app/theme/assets.dart';
import '../../app/theme/color_palette.dart';
import '../../app/theme/fonts.dart';
import '../../core/app_scaffold.dart';
import '../../widget/system_style.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final _model = IoC.get<SplashModel>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _model.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SystemStyle.light(
      systemNavigationBarColor: ColorPalette.transparent,
      child: AppScaffold(
          backgroundColor: ColorPalette.black,
          body: Stack(
            children: [
              bottomPositioned(
                child: Container(
                    height: MediaQuery.of(context).size.height / 2.0,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: Assets.imgWaves, fit: BoxFit.cover),
                    )),
              ),
              Center(
                child: Text(
                  "CAFF Shop",
                  style: Fonts.h1.white,
                ),
              ),
            ],
          )),
    );
  }
}
