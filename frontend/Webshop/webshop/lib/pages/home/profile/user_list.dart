import 'package:flutter/cupertino.dart';
import 'package:webshop/pages/home/profile/user_item.dart';
import 'package:webshop/widget/gaps.dart';
import 'package:webshop/widget/pull_to_refresh.dart';

import '../../../app/theme/sizes.dart';
import '../../../core/content.dart';
import '../../../core/display.dart';
import '../../../models/user.dart';
import '../../../widget/button.dart';
import '../../../widget/slivers.dart';

class UserList extends StatelessWidget {
  final Content<List<User>> content;
  final RefreshCallback onRefresh;
  final Future<void> Function(String) onDelete;
  final VoidCallback onLogout;

  const UserList(
      {super.key,
      required this.content,
      required this.onRefresh,
      required this.onDelete,
      required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Display.single(
      content: content,
      condition: () => content.value != null,
      builder: (_, __) {
        final users = content.value!;
        int count = 0;
        users.forEach((element) {
          if (element.role == Role.user) count++;
        });
        return PullToRefresh(
          onRefresh: onRefresh,
          child: CustomScrollView(
            slivers: [
              SliverChild(child: Vgap.medium()),
              SliverChild(
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.medium),
                  child: Button.primary(
                    text: "Log out",
                    onPressed: onLogout,
                  ),
                ),
              ),
              SliverChild(child: Vgap.medium()),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = users[index];
                    return item.role == Role.user
                        ? Padding(
                            padding: const EdgeInsets.only(
                              left: Sizes.pageMargin,
                              right: Sizes.pageMargin,
                              bottom: Sizes.medium,
                            ),
                            child: UserItem(user: item, onDelete: onDelete),
                          )
                        : Container();
                  },
                  childCount: count,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
