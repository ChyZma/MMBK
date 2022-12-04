import 'package:flutter/material.dart';
import 'package:webshop/pages/home/profile/profile_model.dart';

import '../../../core/display.dart';

class AdminContent extends StatefulWidget {
  final ProfileModel model;

  const AdminContent({super.key, required this.model});

  @override
  State<AdminContent> createState() => _AdminContentState();
}

class _AdminContentState extends State<AdminContent> {
  late final users = widget.model.users;

  @override
  Widget build(BuildContext context) {
    return Display.single(
      content: users,
      condition: () => users.value != null,
      builder: (_, __) {
        return Container();
      },
    );
  }
}
