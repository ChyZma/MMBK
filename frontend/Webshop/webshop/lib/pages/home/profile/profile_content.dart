import 'package:flutter/material.dart';
import 'package:webshop/pages/home/profile/profile_model.dart';

import '../../../app/ioc.dart';
import '../../../app/theme/fonts.dart';
import '../../../app/theme/sizes.dart';
import '../../../core/display.dart';
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
    return Display.multi(
      contents: [widget.model.uiHandler.load, widget.model.user],
      builder: (_, __) {
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
                if (widget.model.path.value == null)
                  FileInput(
                    onChanged: (p) {
                      setState(() {
                        widget.model.path.value = p;
                      });
                    },
                  ),
                if (widget.model.path.value != null) ...[
                  Vgap.medium(),
                  Text(
                    widget.model.fileName,
                    style: Fonts.h5,
                  ),
                  Vgap.medium(),
                  Button.primary(
                    text: 'Caff feltöltése',
                    loading: widget.model.uiHandler.isLoading,
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
      },
    );
  }
}
