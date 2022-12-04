import 'package:flutter/material.dart';
import 'package:webshop/widget/gaps.dart';

import '../../app/ioc.dart';
import '../../app/theme/color_palette.dart';
import '../../app/theme/fonts.dart';
import '../../app/theme/sizes.dart';
import '../../core/app_scaffold.dart';
import '../../routing/app_route.dart';
import '../../widget/button.dart';
import '../../widget/system_style.dart';
import 'login_model.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double contentHeight;

  late final model = IoC.get<LoginModel>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SystemStyle.light(
        systemNavigationBarColor: ColorPalette.transparent,
        child: AppScaffold(
            uiHandler: model.uiHandler,
            backgroundColor: ColorPalette.black,
            body: Padding(
              padding: const EdgeInsets.all(Sizes.medium),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "bejelentkezés",
                    style: Fonts.h2.white,
                  ),
                  const Vgap(Sizes.huge),
                  Container(
                    color: ColorPalette.white,
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "felhasználónév",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: Sizes.medium),
                      ),
                      onChanged: (v) => model.user.userName = v,
                    ),
                  ),
                  const Vgap(Sizes.medium),
                  Container(
                    color: ColorPalette.white,
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "jelszó",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: Sizes.medium),
                      ),
                      obscureText: true,
                      onChanged: (v) => model.user.password = v,
                    ),
                  ),
                  const Vgap(Sizes.big),
                  Button.primary(
                    text: "bejelentkezés",
                    onPressed: () {
                      model.login();
                    },
                  ),
                  const Vgap(Sizes.giant),
                  Button.primary(
                    text: "regisztráció",
                    onPressed: () {
                      IoC.router.push(AppRoute.signUp());
                    },
                  ),
                ],
              ),
            )));
  }
}
