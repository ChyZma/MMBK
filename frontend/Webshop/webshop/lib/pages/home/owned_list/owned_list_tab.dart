import 'package:flutter/material.dart';
import 'package:webshop/pages/home/owned_list/owned_list.dart';

import '../../../app/theme/color_palette.dart';
import '../../../app/theme/fonts.dart';
import '../../../core/app_scaffold.dart';
import 'owned_list_model.dart';

class OwnedListTab extends StatelessWidget {
  final OwnedModel model;

  const OwnedListTab({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      uiHandler: model.uiHandler,
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Your Caffs',
            style: Fonts.h3,
          ),
        ),
        backgroundColor: ColorPalette.gray10,
      ),
      body: OwnedList(model: model),
    );
  }
}
