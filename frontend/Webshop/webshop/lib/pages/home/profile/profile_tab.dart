import 'package:flutter/material.dart';
import 'package:webshop/pages/home/profile/profile_content.dart';
import 'package:webshop/pages/home/profile/profile_model.dart';

import '../../../app/theme/color_palette.dart';
import '../../../app/theme/fonts.dart';
import '../../../core/app_scaffold.dart';
import '../../../models/user.dart';

class ProfileTab extends StatefulWidget {
  final ProfileModel model;

  const ProfileTab({super.key, required this.model});

  @override
  State<StatefulWidget> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      uiHandler: widget.model.uiHandler,
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Profile',
            style: Fonts.h3,
          ),
        ),
        backgroundColor: ColorPalette.gray10,
      ),
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          children: [
            if (widget.model.user.value!.role == Role.user) ...[
              ProfileContent(model: widget.model),
            ] else if (widget.model.user.value!.role == Role.admin) ...[
              // AdminProfileContent(model: widget.model)
            ]
          ],
        ),
      ),
    );
  }
}
