import 'package:flutter/material.dart';

import '../../app/ioc.dart';
import '../../app/theme/color_palette.dart';
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => IoC.router.pop(),
        ),
        title: Text(_model.name),
        backgroundColor: ColorPalette.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
