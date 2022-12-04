import 'package:flutter/material.dart';
import 'package:webshop/pages/home/profile/profile_model.dart';

import '../../../app/theme/fonts.dart';
import '../../../app/theme/sizes.dart';
import '../../../widget/gaps.dart';

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
              'Hello, ${user.name!} (${user.role.name})!',
              style: Fonts.medium,
            ),
            const Vgap(30),
          ],
        ),
      ),
    );
  }
}
