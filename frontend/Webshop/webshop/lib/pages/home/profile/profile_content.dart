import 'package:flutter/material.dart';
import 'package:webshop/pages/home/profile/profile_model.dart';

import '../../../app/ioc.dart';
import '../../../app/theme/fonts.dart';
import '../../../app/theme/sizes.dart';
import '../../../routing/app_route.dart';
import '../../../widget/button.dart';
import '../../../widget/gaps.dart';
import 'file_input.dart';

class ProfileContent extends StatefulWidget {
  final ProfileModel model;

  const ProfileContent({super.key, required this.model});

  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  @override
  Widget build(BuildContext context) {
    final user = widget.model.user.value!;

    return Padding(
      padding: const EdgeInsets.all(Sizes.medium),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Vgap(Sizes.giant),
            Text(
              'Hello, ${user.name!}!',
              style: Fonts.medium,
            ),
            const Vgap(30),
            const Text(
              'Új caff fálj feltöltése',
              style: Fonts.smallTitle,
            ),
            Vgap.small(),
            if (widget.model.path == null)
              FileInput(
                onChanged: (p) {
                  setState(() {
                    widget.model.path = p;
                  });
                },
              ),
            if (widget.model.path != null) ...[
              Vgap.medium(),
              Button.primary(
                text: 'Caff feltöltése',
                onPressed: () {
                  widget.model.uploadCaff();
                },
              ),
            ],
            const Vgap(Sizes.huge),
            Button.primary(
              text: "Log out",
              onPressed: () {
                widget.model.logOut();
                IoC.router.set(AppRoute.login());
              },
            ),
            Vgap.medium(),
          ],
        ),
      ),
    );
  }
}
