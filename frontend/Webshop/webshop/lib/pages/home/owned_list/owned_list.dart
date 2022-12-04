import 'package:flutter/material.dart';

import '../../../app/theme/fonts.dart';
import '../../../app/theme/sizes.dart';
import '../../../core/display.dart';
import '../../../widget/gaps.dart';
import '../../../widget/pull_to_refresh.dart';
import '../../../widget/slivers.dart';
import '../shop_list/shop_list_item.dart';
import 'owned_list_model.dart';

class OwnedList extends StatefulWidget {
  final OwnedModel model;

  const OwnedList({super.key, required this.model});

  @override
  State<OwnedList> createState() => _OwnedListState();
}

class _OwnedListState extends State<OwnedList> {
  late final _model = widget.model;
  late final content = _model.caffs;

  @override
  Widget build(BuildContext context) {
    if (content.value == null || content.value!.isEmpty) {
      return const Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: Text(
            "Nincs megvásárolt CAFF",
            style: Fonts.big,
          ),
        ),
      );
    }

    return Display.single(
      content: content,
      condition: () => content.value != null,
      builder: (_, __) {
        final caff = content.value!;

        return PullToRefresh(
          onRefresh: _model.onRefresh,
          child: CustomScrollView(
            slivers: [
              SliverChild(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.all(Sizes.small),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey.shade100)),
                    ),
                  ),
                ),
              ),
              SliverChild(child: Vgap.page()),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = caff[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: Sizes.pageMargin,
                        right: Sizes.pageMargin,
                        bottom: Sizes.medium,
                      ),
                      child:
                          //todo: caffitem
                          ShopListItem(model: item),
                    );
                  },
                  childCount: caff.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
