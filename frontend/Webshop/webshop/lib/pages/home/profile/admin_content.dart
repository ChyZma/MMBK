import 'package:flutter/material.dart';
import 'package:webshop/pages/home/profile/profile_model.dart';
import 'package:webshop/pages/home/profile/user_list.dart';

import '../../../app/ioc.dart';
import '../../../core/display.dart';
import '../../../routing/app_route.dart';

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
        return UserList(
          content: users,
          onRefresh: widget.model.refresh,
          onDelete: (String id) async {
            await widget.model.deleteUser(id);
          },
          onLogout: () {
            widget.model.logOut();
            IoC.router.set(AppRoute.login());
          },
        );
      },
    );
  }
}
