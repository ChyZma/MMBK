import 'package:flutter/material.dart';
import 'package:webshop/app/theme/fonts.dart';
import 'package:webshop/widget/gaps.dart';

import '../../app/ioc.dart';
import '../../app/theme/assets.dart';
import '../../app/theme/color_palette.dart';
import '../../app/theme/sizes.dart';
import '../../core/app_scaffold.dart';
import '../../models/caff.dart';

class CaffInfoPage extends StatefulWidget {
  final Caff model;
  const CaffInfoPage({super.key, required this.model});

  @override
  State<CaffInfoPage> createState() => _CaffInfoPageState();
}

class _CaffInfoPageState extends State<CaffInfoPage> {
  late final _model = widget.model;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => IoC.router.pop(),
        ),
        title: Text(_model.name),
        backgroundColor: ColorPalette.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (_model.gif != null)
                ? Container(
                    height: 280,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: MemoryImage(_model.gif!)),
                    ),
                  )
                : const SizedBox(
                    height: 280,
                    child: Image(
                      image: Assets.gifSuccess,
                    ),
                  ),
            const Vgap(Sizes.medium),
            Row(
              children: [
                Text(
                  _model.name,
                  style: Fonts.h4,
                ),
              ],
            ),
            const Vgap(Sizes.medium),
            // const Text('Hozzászólások'),
          ],
        ),
      ),
    );
  }
}
