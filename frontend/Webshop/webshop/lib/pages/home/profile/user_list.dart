import 'package:flutter/cupertino.dart';
import 'package:webshop/widget/gaps.dart';
import 'package:webshop/widget/pull_to_refresh.dart';

import '../../../app/theme/sizes.dart';
import '../../../core/content.dart';
import '../../../core/display.dart';
import '../../../models/user.dart';
import '../../../widget/slivers.dart';

class UserList extends StatelessWidget {
  final Content<List<User>> content;
  final RefreshCallback onRefresh;
  final Function(int) onDelete;

  const UserList(
      {super.key,
      required this.content,
      required this.onRefresh,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Display.single(
      content: content,
      condition: () => content.value != null,
      builder: (_, __) {
        final users = content.value!;
        return PullToRefresh(
          onRefresh: onRefresh,
          child: CustomScrollView(
            slivers: [
              SliverChild(child: Vgap.medium()),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = users[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: Sizes.pageMargin,
                        right: Sizes.pageMargin,
                        bottom: Sizes.medium,
                      ),
                      child: Container(),
                    );
                  },
                  childCount: users.length,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
