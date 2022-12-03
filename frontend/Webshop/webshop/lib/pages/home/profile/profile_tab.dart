import 'package:flutter/material.dart';
import 'package:webshop/pages/home/profile/profile_content.dart';
import 'package:webshop/pages/home/profile/profile_model.dart';

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
    return SingleChildScrollView(
      controller: _controller,
      child: Column(
        children: [
          ProfileContent(model: widget.model),
        ],
      ),
    );
  }
}
