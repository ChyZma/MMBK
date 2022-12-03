import 'package:flutter/material.dart';
import 'package:webshop/pages/home/profile/profile_model.dart';

import '../../../app/ioc.dart';
import '../../../app/theme/fonts.dart';
import '../../../app/theme/sizes.dart';
import '../../../routing/app_route.dart';
import '../../../widget/button.dart';
import '../../../widget/gaps.dart';

class ProfileContent extends StatelessWidget {
  final ProfileModel model;

  const ProfileContent({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final user = model.user.value!;

    return Padding(
      padding: const EdgeInsets.all(Sizes.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user.name!,
            style: Fonts.medium,
          ),
          const Vgap(30),
          Button.primary(
            text: "Log out",
            onPressed: () {
              model.logOut();
              IoC.router.set(AppRoute.login());
            },
          ),
          Vgap.medium(),
        ],
      ),
    );
  }
}
